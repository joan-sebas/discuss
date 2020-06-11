import { Socket } from 'phoenix';

let socket = new Socket('/socket', { params: { token: window.userToken } });
var calendarEl = document.getElementById('calendar');

var calendar = new FullCalendar.Calendar(calendarEl, {
  plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list' ],
  header: {
    left: 'prev,next today',
    center: 'title',
    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
  },
  defaultDate: '2020-06-12',
  navLinks: true, // can click day/week names to navigate views
  businessHours: true, // display business hours
  editable: true,


});

var events = new Event('build');
socket.connect();

const createSocket = reservaId=> {
  let channel = socket.channel(`jugador_reservas:${reservaId}`, {});
  channel
    .join()
    .receive('ok', resp => {
      document.dispatchEvent(events);
        console.log(resp)
      console.log("ok",resp);
      renderJugador_reservas(resp.jugador_reserva);
    })
    .receive('error', resp => {
      console.log(resp)
      console.log('Unable to join', resp);
    });

  channel.on(`jugador_reservas:${reservaId}:new`, renderJugador_reserva);

  document.querySelector('button').addEventListener('click', () => {



    calendar.addEvent( {
      title: 'Businesss Lunch',
      start: '2020-05-03T13:00:00',
      constraint: 'businessHours',
      editable: false
    });
    document.dispatchEvent(events);
    calendar.render();

  });
  document.addEventListener('build', () => {
    calendar.render();
  });

  document.addEventListener('build2', () => {

    var copia= calendar.getEvents();
  copia.forEach(element =>calendar2.addEvent(element));
  console.log(calendar.getEvents());

    calendar2.render();
  });


};

function renderJugador_reservas(jugador_reservas) {
  const renderedJugador_reservas = Jugador_reservaTemplate(jugador_reservas);
  ;

  document.querySelector('.collection').innerHTML = renderedJugador_reservas;
}

function renderJugador_reserva(event) {
  const renderedJugador_reserva = Jugador_reservaTemplate(event.jugador_reserva);

  document.querySelector('.collection').innerHTML += renderedJugador_reserva;
}

function Jugador_reservaTemplate(jugador_reserva) {


  return `
  <script>
  var calendario = ${calendar}
  calendario.render();

  </script>
  `;
}

window.createSocket = createSocket;
