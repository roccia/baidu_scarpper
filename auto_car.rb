
require 'pi_piper'
include PiPiper

class AutoCar

  def initialize
    @s1 = PiPiper::Pin.new(:direction => :out, :pin => 23) #N3
    @s2 = PiPiper::Pin.new(:direction => :out, :pin => 24) #N4
    @s3 = PiPiper::Pin.new(:direction => :out, :pin => 20) #N1
    @s4 = PiPiper::Pin.new(:direction => :out, :pin => 21) #N2
    @s5 = PiPiper::Pin.new(:direction => :out, :pin => 25) #ENB
    @s6 = PiPiper::Pin.new(:direction => :out, :pin => 16) #ENA
  end

  def reset
   @s1.off
   @s2.off
   @s3.off
   @s4.off
   @s5.off
   @s6.off
  end

  #右前轮
  def front_right_forward
    @s5.on
    @s2.on
    @s3.off
  end

  def fornt_right_backward
    @s5.on
    @s2.off
    @s3.on
  end

  #右后轮
  def back_right_forwad
    @s6.on
    @s4.on
    @s5.off
  end

  def back_right_backward
    @s6.on
    @s4.off
    @s5.on
  end

  def stop
    reset
  end

end
   a = AutoCar.new
   a.fornt_right_backward