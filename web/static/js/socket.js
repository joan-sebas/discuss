import { Socket } from 'phoenix';



let socket = new Socket('/socket', { params: { token: window.userToken } });

var calendarEl = document.getElementById('calendar');


var calendar




socket.connect();
var user=0

const createSocket = reservaId=> {


let  channel = socket.channel(`jugador_reservas:${reservaId}`, {});

  channel
    .join()
    .receive('ok', resp => {
        asignarUser(resp.user)
        eventoTrigger(calendar, user);

        console.log(user);
      console.log("ok",resp);

    })
    .receive('error', resp => {
      console.log(resp)
      console.log('Unable to join', resp);
    });

  channel.on(`jugador_reservas:${reservaId}:new`, mssg=>   eventoTrigger(calendar,user));

console.log(socket);
  document.querySelector('button').addEventListener('click', () => {


               var dateStr = prompt('Enter a date in YYYY-MM-DD hh format');
               var date = new Date(dateStr + ':00:00'); // will be in local time

               if (!isNaN(date.valueOf())) { // valid?
                 console.log(date);
                 console.log(moment(date).format("HH:mm:ss"));
                 channel.push('jugador_reservas:add', { startDate: moment(date).format("YYYY-MM-DD") , startTime: moment(date).format("HH:mm:ss"), agregar: true  });
                 calendar.addEvent({
                   title: 'dynamic event',
                   start: date

                 });
                 alert('Great. Now, update your database...');
               } else {
                 alert('Invalid date.');
               }
               calendar.render();
  });


let calendar= crearCalendario(channel);






};





function asignarUser(usuario){
  user=usuario
}
function crearCalendario(channel){
  let Calendar = FullCalendar.Calendar;
    let Draggable = FullCalendarInteraction.Draggable

    /* initialize the external events
    -----------------------------------------------------------------*/

    let containerEl = document.getElementById('external-events-list');
    new Draggable(containerEl, {
      itemSelector: '.fc-event',
      eventData: function(eventEl) {
        return {
          title: eventEl.innerText.trim(),
          color: "#257e4a"
        }
      },

    });
  let calendarEl = document.getElementById('calendar');


  let calendar = new Calendar(calendarEl, {
    plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list' ],
    header: {
      left: 'prev,next today',
      center: 'addEventButton,title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
    },
    defaultDate: '2020-06-12',
    navLinks: true, // can click day/week names to navigate views
     // display business hours
    editable: true,

    eventDrop: function(info) {

      console.log(moment(info.event.start).format("mm:ss"));
       if (moment(info.event.start).format("mm:ss") !="00:00") {
       info.revert();
     } else{
       channel.push('jugador_reservas:add', { startDate: moment(info.event.start).format("YYYY-MM-DD") , startTime: moment(info.event.start).format("HH:mm:ss") , agregar: true});
      channel.push('jugador_reservas:add', { startDate: moment(info.oldEvent.start).format("YYYY-MM-DD") , startTime: moment(info.oldEvent.start).format("HH:mm:ss") , agregar: false});


     }
   },
   eventClick: function(info){
     console.log(info.event.startEditable);
  if(info.event.startEditable){
     var opcion = confirm("Seguro desea eliminar este evento");

  if (opcion == true) {
channel.push('jugador_reservas:add', { startDate: moment(info.event.start).format("YYYY-MM-DD") , startTime: moment(info.event.start).format("HH:mm:ss") , agregar: false});
  }
}
},
   eventReceive: function(info) {

     console.log(moment(info.event.start).format("mm:ss"));
      if (moment(info.event.start).format("mm:ss") !="00:00") {
      alert("Evento no guardado no se puede seleccionar :30 en los minutos");
      location.reload();
    } else{
      channel.push('jugador_reservas:add', { startDate: moment(info.event.start).format("YYYY-MM-DD") , startTime: moment(info.event.start).format("HH:mm:ss") , agregar: true});


    }
  },
    events: {
    }

  });

  return calendar


}

  //document.addEventListener('build2', () => {

    //var copia= calendar.getEvents();
  //copia.forEach(element =>calendar2.addEvent(element));
  //console.log(calendar.getEvents());

  //  calendar2.render();
//  });

function eventoTrigger(calendar, user){
  const renderedJugador_reservas = Jugador_reservaTemplate(user);
  ;

  document.querySelector('.row').innerHTML = renderedJugador_reservas;
  $.ajax({
    url: "http://localhost:4000/api/events",
  method: "GET",
  datatype: "json",
  data:{
    user: user
  },
  success: function(data){

    let remover = calendar.getEvents();
      remover.forEach(element =>element.remove());
      data.forEach(element =>calendar.addEvent(element));

  }

  });


  calendar.render();
}


function renderJugador_reservas(jugador_reservas) {
  const renderedJugador_reservas = Jugador_reservaTemplate(jugador_reservas);
  ;

  document.querySelector('.row').innerHTML = renderedJugador_reservas;
}

function renderJugador_reserva(event) {
  const renderedJugador_reserva = Jugador_reservaTemplate(event.jugador_reserva);

  document.querySelector('.row').innerHTML += renderedJugador_reserva;
}

function Jugador_reservaTemplate(jugador_reserva) {


  return `
  <div class="col s12 m6">
    <div class="card blue-grey darken-1">
      <div class="card-content white-text">
        <span class="card-title">Card Title</span>
        <p>I am a very simple card. I am good at containing small bits of information.
        I am convenient because I require little markup to use effectively.</p>
      </div>
      <div class="card-action">
        <a href="#">This is a link</a>
        <a href="#">This is a link</a>
      </div>
    </div>
  </div>
  `;
}

window.createSocket = createSocket;
