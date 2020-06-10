import { Socket } from 'phoenix';

let socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();
var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
  plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list' ],
  header: {
    left: 'prev,next today',
    center: 'title',
    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
  },
  defaultDate: '2020-05-12',
  navLinks: true, // can click day/week names to navigate views
  businessHours: true, // display business hours
  editable: true,
  events: [
    {
      title: 'Business Lunch',
      start: '2020-05-03T13:00:00',
      constraint: 'businessHours'
    },
    {
      title: 'Meeting',
      start: '2020-05-13T11:00:00',
      constraint: 'availableForMeeting', // defined below
      color: '#257e4a'
    },
    {
      title: 'Conference',
      start: '2020-05-18',
      end: '2020-05-20'
    },
    {
      title: 'Party',
      start: '2020-05-29T20:00:00'
    },

    // areas where "Meeting" must be dropped
    {
      groupId: 'availableForMeeting',
      start: '2020-05-11T10:00:00',
      end: '2020-05-11T16:00:00',
      rendering: 'background'
    },
    {
      groupId: 'availableForMeeting',
      start: '2020-05-13T10:00:00',
      end: '2020-05-13T16:00:00',
      rendering: 'background'
    },

    // red areas where no events can be dropped
    {
      start: '2020-05-24',
      end: '2020-05-28',
      overlap: false,
      rendering: 'background',
      color: '#ff9f89'
    },
    {
      start: '2020-05-06',
      end: '2020-05-08',
      overlap: false,
      rendering: 'background',
      color: '#ff9f89'
    }
  ]
});
const createSocket = reservaId=> {
  let channel = socket.channel(`jugador_reservas:${reservaId}`, {});
  channel
    .join()
    .receive('ok', resp => {
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
      constraint: 'businessHours'
    });
    calendar.render();

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

  ${calendar}.render();

  </script>
  `;
}

window.createSocket = createSocket;
