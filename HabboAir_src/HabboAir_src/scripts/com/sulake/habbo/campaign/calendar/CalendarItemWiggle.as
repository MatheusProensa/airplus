package com.sulake.habbo.campaign.calendar
{
   import com.sulake.core.window.IWindowModel;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CalendarItemWiggle
   {
      private static const TIMER_INTERVAL:int = 80;
      
      private static const UnknownConstFromCalendarItemWiggle_Int_1:int = 10;
      
      private static const UnknownConstFromCalendarItemWiggle_Int_2:int = 40;
      
      private static const UnknownConstFromCalendarItemWiggle_Int_3:int = 7;
      
      private var _window:IWindowModel;
      
      private var UnknownVarFromCalendarItemWiggle_Timer_1:Timer;
      
      private var UnknownVarFromCalendarItemWiggle_Int_1:int;
      
      private var UnknownVarFromCalendarItemWiggle_Int_2:int;
      
      private var UnknownVarFromCalendarItemWiggle_Int_3:int;
      
      public function CalendarItemWiggle(param1:IWindowModel)
      {
         super();
         if(!param1)
         {
            return;
         }
         _window = param1;
         UnknownVarFromCalendarItemWiggle_Int_3 = param1.y;
         param1.y -= 10;
         UnknownVarFromCalendarItemWiggle_Int_1 = 1;
         UnknownVarFromCalendarItemWiggle_Timer_1 = new Timer(80);
         UnknownVarFromCalendarItemWiggle_Timer_1.addEventListener("timer",onTimerEvent);
         UnknownVarFromCalendarItemWiggle_Timer_1.start();
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         if(!_window)
         {
            dispose();
         }
         var _loc3_:Number = 10 * ((7 - UnknownVarFromCalendarItemWiggle_Int_2) / 7);
         var _loc4_:Number = Math.abs(_window.y - UnknownVarFromCalendarItemWiggle_Int_3) / _loc3_;
         var _loc2_:Number = Math.max(2,Math.sin(_loc4_) * 40) * UnknownVarFromCalendarItemWiggle_Int_1;
         _window.y += _loc2_;
         if(UnknownVarFromCalendarItemWiggle_Int_1 > 0)
         {
            if(_window.y > UnknownVarFromCalendarItemWiggle_Int_3)
            {
               UnknownVarFromCalendarItemWiggle_Int_1 *= -1;
               _window.y = UnknownVarFromCalendarItemWiggle_Int_3;
               UnknownVarFromCalendarItemWiggle_Int_2++;
            }
         }
         else if(_window.y <= UnknownVarFromCalendarItemWiggle_Int_3 - _loc3_)
         {
            UnknownVarFromCalendarItemWiggle_Int_1 *= -1;
            _window.y = UnknownVarFromCalendarItemWiggle_Int_3 - _loc3_;
            UnknownVarFromCalendarItemWiggle_Int_2++;
         }
         if(UnknownVarFromCalendarItemWiggle_Int_2 >= 7)
         {
            dispose();
         }
      }
      
      private function dispose() : void
      {
         _window.y = UnknownVarFromCalendarItemWiggle_Int_3;
         _window = null;
         UnknownVarFromCalendarItemWiggle_Timer_1.reset();
         UnknownVarFromCalendarItemWiggle_Timer_1 = null;
      }
   }
}

