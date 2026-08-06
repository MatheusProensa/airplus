package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CraftingProgressBarController
   {
      private var UnknownVarFromCraftingProgressBarController_CraftingWidget_1:CraftingWidget;
      
      private var UnknownVarFromCraftingProgressBarController_Timer_1:Timer;
      
      private var UnknownVarFromCraftingProgressBarController_Number_1:Number;
      
      public function CraftingProgressBarController(param1:CraftingWidget)
      {
         super();
         UnknownVarFromCraftingProgressBarController_CraftingWidget_1 = param1;
         UnknownVarFromCraftingProgressBarController_Timer_1 = new Timer(70);
         UnknownVarFromCraftingProgressBarController_Timer_1.addEventListener("timer",onProgressTimerEvent);
      }
      
      public function dispose() : void
      {
         UnknownVarFromCraftingProgressBarController_CraftingWidget_1 = null;
      }
      
      private function setProgress(param1:Number) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:IWindowModel = container.findChildByName("btn_cancel");
         var _loc4_:IWindowModel = !!container ? container.findChildByName("bar") : null;
         if(_loc4_)
         {
            _loc3_ = _loc4_.parent;
            _loc4_.width = _loc2_.width * param1;
         }
      }
      
      private function onProgressTimerEvent(param1:TimerEvent) : void
      {
         setProgress(UnknownVarFromCraftingProgressBarController_Number_1 = UnknownVarFromCraftingProgressBarController_Number_1 + 0.02);
         if(UnknownVarFromCraftingProgressBarController_Number_1 >= 1)
         {
            hide();
            UnknownVarFromCraftingProgressBarController_CraftingWidget_1.infoCtrl.onProgressBarComplete();
         }
      }
      
      public function hide() : void
      {
         if(UnknownVarFromCraftingProgressBarController_Timer_1)
         {
            UnknownVarFromCraftingProgressBarController_Timer_1.stop();
         }
         if(container)
         {
            container.visible = false;
            container.procedure = null;
         }
      }
      
      public function show() : void
      {
         UnknownVarFromCraftingProgressBarController_Timer_1.start();
         UnknownVarFromCraftingProgressBarController_Number_1 = 0;
         if(container)
         {
            container.visible = true;
            container.procedure = onTriggered;
         }
      }
      
      private function onTriggered(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         UnknownVarFromCraftingProgressBarController_CraftingWidget_1.infoCtrl.cancelCrafting();
      }
      
      private function get container() : IWindowController_1
      {
         if(!UnknownVarFromCraftingProgressBarController_CraftingWidget_1 || !UnknownVarFromCraftingProgressBarController_CraftingWidget_1.window)
         {
            return null;
         }
         return UnknownVarFromCraftingProgressBarController_CraftingWidget_1.window.findChildByName("progress_bar") as IWindowController_1;
      }
   }
}

