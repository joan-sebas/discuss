defmodule Discuss.EventsView do
  use Discuss.Web, :view

  def render("index.json", %{events: events}) do

 Enum.map(events, &events_json/1)

end



def events_json(events) do

  %{
     title: "Equipo",
     start: Enum.join([events.startDate, events.startTime], " "),
     end: Enum.join([events.endDate, events.endTime], " "),
    durationEditable: false,
    color: events.color,
    editable: events.edit
  }
end
# show single blog

end
