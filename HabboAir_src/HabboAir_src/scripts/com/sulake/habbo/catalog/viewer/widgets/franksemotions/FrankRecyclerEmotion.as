package com.sulake.habbo.catalog.viewer.widgets.franksemotions
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class FrankRecyclerEmotion
   {
      private static var UnknownVarFromFrankRecyclerEmotion_Array_1:Array = [];
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromFrankRecyclerEmotion_Timer_1:Timer;
      
      private var _startTime:int;
      
      private var UnknownVarFromFrankRecyclerEmotion_Number_1:Number;
      
      private var UnknownVarFromFrankRecyclerEmotion_Number_2:Number;
      
      public function FrankRecyclerEmotion(param1:IStaticBitmapWrapperWindow)
      {
         super();
         if(UnknownVarFromFrankRecyclerEmotion_Array_1.length > 0)
         {
            _bitmap = UnknownVarFromFrankRecyclerEmotion_Array_1.pop() as IStaticBitmapWrapperWindow;
            _bitmap.y = param1.y;
         }
         else
         {
            _bitmap = param1.clone() as IStaticBitmapWrapperWindow;
         }
         var _loc3_:Array = ["franks_emotions_blush","franks_emotions_heart"];
         var _loc4_:int = Math.floor(Math.random() * _loc3_.length);
         var _loc2_:String = _loc3_[_loc4_];
         _bitmap.assetUri = _loc2_;
         _bitmap.x += Math.floor(Math.random() * 70) - 20;
         UnknownVarFromFrankRecyclerEmotion_Number_2 = -(Math.random() * 80 + 30);
         _bitmap.blend = 0;
      }
      
      public function start(param1:IWindowController_1) : void
      {
         param1.addChild(_bitmap);
         _startTime = getTimer();
         UnknownVarFromFrankRecyclerEmotion_Number_1 = _bitmap.y;
         UnknownVarFromFrankRecyclerEmotion_Timer_1 = new Timer(16.666666666666668);
         UnknownVarFromFrankRecyclerEmotion_Timer_1.addEventListener("timer",onTick);
         UnknownVarFromFrankRecyclerEmotion_Timer_1.start();
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(_bitmap.disposed)
         {
            UnknownVarFromFrankRecyclerEmotion_Timer_1.stop();
            UnknownVarFromFrankRecyclerEmotion_Timer_1.removeEventListener("timer",onTick);
            UnknownVarFromFrankRecyclerEmotion_Timer_1 = null;
            _bitmap = null;
         }
         var _loc2_:Number = (getTimer() - _startTime) / 1000;
         var _loc3_:Number = Math.min(1,_loc2_ * 1.25);
         if(_loc3_ > _bitmap.blend + 0.1 || _bitmap.blend < 1 && _loc3_ == 1)
         {
            _bitmap.blend = _loc3_;
         }
         _bitmap.y = UnknownVarFromFrankRecyclerEmotion_Number_1 + UnknownVarFromFrankRecyclerEmotion_Number_2 * _loc2_;
         if(_bitmap.y < -50)
         {
            UnknownVarFromFrankRecyclerEmotion_Timer_1.stop();
            UnknownVarFromFrankRecyclerEmotion_Timer_1.removeEventListener("timer",onTick);
            UnknownVarFromFrankRecyclerEmotion_Timer_1 = null;
            if(_bitmap.parent)
            {
               _bitmap.parent = null;
            }
            UnknownVarFromFrankRecyclerEmotion_Array_1.push(_bitmap);
         }
      }
   }
}

