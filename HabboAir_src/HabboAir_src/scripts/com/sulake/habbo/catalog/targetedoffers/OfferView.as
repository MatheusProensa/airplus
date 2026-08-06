package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   import com.sulake.habbo.catalog.targetedoffers.util.UnknownHabboCatalogTargetedoffersUtil2;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class OfferView implements IComponentInterfaceQueue
   {
      protected var _window:IWindowController_1;
      
      protected var UnknownVarFromOfferView_OfferController_1:OfferController;
      
      protected var _offer:TargetedOffer;
      
      protected var UnknownVarFromOfferView_Timer_1:Timer;
      
      protected var _disposed:Boolean;
      
      protected var UnknownVarFromOfferView_String_1:String;
      
      public function OfferView(param1:OfferController, param2:TargetedOffer)
      {
         super();
         UnknownVarFromOfferView_OfferController_1 = param1;
         _offer = param2;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromOfferView_Timer_1 != null)
         {
            UnknownVarFromOfferView_Timer_1.stop();
            UnknownVarFromOfferView_Timer_1 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function startUpdateTimer() : void
      {
         UnknownVarFromOfferView_Timer_1 = new Timer(1000);
         UnknownVarFromOfferView_Timer_1.addEventListener("timer",onUpdateTimer);
         UnknownVarFromOfferView_Timer_1.start();
         updateRemainingTime();
      }
      
      protected function onUpdateTimer(param1:TimerEvent) : void
      {
         updateRemainingTime();
      }
      
      protected function updateRemainingTime() : void
      {
         setTimeLeft(UnknownHabboCatalogTargetedoffersUtil2.getStringFromSeconds(UnknownVarFromOfferView_OfferController_1.catalog.localization,_offer.getSecondsRemaining()));
         if(_offer.getSecondsRemaining() == 0)
         {
            UnknownVarFromOfferView_OfferController_1.destroyView();
         }
      }
      
      protected function setTimeLeft(param1:String) : void
      {
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left"));
         if(!_loc2_)
         {
            return;
         }
         _loc2_.text = UnknownVarFromOfferView_String_1 != "" ? UnknownVarFromOfferView_String_1.replace("%timeleft%",param1) : param1;
      }
      
      protected function getLocalization(param1:String, param2:String = null) : String
      {
         var _loc3_:String = UnknownVarFromOfferView_OfferController_1.catalog.localization.getLocalization(param1,param2 || param1);
         if(!_loc3_)
         {
            return null;
         }
         if(_offer)
         {
            _loc3_ = _loc3_.replace("%itemsleft%",_offer.purchaseLimit);
         }
         return _loc3_;
      }
   }
}

