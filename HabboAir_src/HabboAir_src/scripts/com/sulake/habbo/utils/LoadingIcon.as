package com.sulake.habbo.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IIconWindow;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class LoadingIcon implements IComponentInterfaceQueue
   {
      private static const FRAMES:Array = [23,24,25,26];
      
      private var UnknownVarFromLoadingIcon_Timer_1:Timer = new Timer(160);
      
      private var _icon:IIconWindow;
      
      private var UnknownVarFromLoadingIcon_Int_1:int;
      
      public function LoadingIcon()
      {
         super();
         UnknownVarFromLoadingIcon_Timer_1.addEventListener("timer",onTimer);
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromLoadingIcon_Timer_1)
         {
            UnknownVarFromLoadingIcon_Timer_1.removeEventListener("timer",onTimer);
            UnknownVarFromLoadingIcon_Timer_1.stop();
            UnknownVarFromLoadingIcon_Timer_1 = null;
         }
         _icon = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromLoadingIcon_Timer_1 == null;
      }
      
      public function setVisible(param1:IIconWindow, param2:Boolean) : void
      {
         _icon = param1;
         if(_icon == null)
         {
            return;
         }
         _icon.visible = param2;
         if(param2)
         {
            _icon.style = FRAMES[UnknownVarFromLoadingIcon_Int_1];
            UnknownVarFromLoadingIcon_Timer_1.start();
         }
         else
         {
            UnknownVarFromLoadingIcon_Timer_1.stop();
         }
      }
      
      private function onTimer(param1:Event) : void
      {
         if(_icon == null)
         {
            return;
         }
         UnknownVarFromLoadingIcon_Int_1++;
         if(UnknownVarFromLoadingIcon_Int_1 >= FRAMES.length)
         {
            UnknownVarFromLoadingIcon_Int_1 = 0;
         }
         _icon.style = FRAMES[UnknownVarFromLoadingIcon_Int_1];
      }
   }
}

