defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  @spec new(String.t()) :: %RemoteControlCar{}
  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  @spec display_distance(%RemoteControlCar{}) :: String.t()
  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  @spec display_battery(%RemoteControlCar{}) :: String.t()
  def display_battery(%RemoteControlCar{battery_percentage: 0} = _remote_car), do: "Battery empty"

  def display_battery(%RemoteControlCar{} = remote_car) do
    "Battery at #{remote_car.battery_percentage}%"
  end

  @spec drive(%RemoteControlCar{}) :: %RemoteControlCar{}
  def drive(%RemoteControlCar{battery_percentage: 0} = remote_car), do: remote_car

  def drive(%RemoteControlCar{} = remote_car) do
    distance = remote_car.distance_driven_in_meters + 20
    battery = remote_car.battery_percentage - 1

    %RemoteControlCar{
      remote_car
      | distance_driven_in_meters: distance,
        battery_percentage: battery
    }
  end
end
