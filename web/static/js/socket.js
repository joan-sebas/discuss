import { Socket } from 'phoenix';



let socket = new Socket('/socket', { params: { token: window.userToken } });

var calendarEl = document.getElementById('calendar');


var calendar




socket.connect();


const createSocket = reservaId=> {


let  channel = socket.channel(`jugador_reservas:${reservaId}`, {});

  channel
    .join()
    .receive('ok', resp => {

        console.log(resp);
      console.log("ok",resp);

    })
    .receive('error', resp => {
      console.log(resp)
      console.log('Unable to join', resp);
    });

  channel.on(`jugador_reservas:${reservaId}:new`, mssg=>   eventoTrigger(calendar));


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
  eventoTrigger(calendar);





};






function crearCalendario(channel){
  let calendarEl = document.getElementById('calendar');


  let calendar = new FullCalendar.Calendar(calendarEl, {
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

function eventoTrigger(calendar){
  $.ajax({
    url: "http://localhost:4000/api/events",
  method: "GET",
  datatype: "json",
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

  document.querySelector('.collection').innerHTML = renderedJugador_reservas;
}

function renderJugador_reserva(event) {
  const renderedJugador_reserva = Jugador_reservaTemplate(event.jugador_reserva);

  document.querySelector('.collection').innerHTML += renderedJugador_reserva;
}

function Jugador_reservaTemplate(jugador_reserva) {


  return `

  `;
}

window.createSocket = createSocket;
