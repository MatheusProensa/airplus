package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   
   public class PollOfferDialog implements IPollOfferDialog
   {
      public static const OK:String = "POLL_OFFER_STATE_OK";
      
      public static const CANCEL:String = "POLL_OFFER_STATE_CANCEL";
      
      public static const UNKNOWN:String = "POLL_OFFER_STATE_UNKNOWN";
      
      private var _disposed:Boolean = false;
      
      private var _window:IFrameController;
      
      private var _state:String = "POLL_OFFER_STATE_UNKNOWN";
      
      private var UnknownVarFromPollOfferDialog_PollWidget_1:PollWidget;
      
      private var UnknownVarFromPollOfferDialog_Int_1:int = -1;
      
      public function PollOfferDialog(param1:int, param2:String, param3:String, param4:PollWidget)
      {
         var _loc9_:IWindowModel = null;
         var _loc5_:IWindowModel = null;
         var _loc7_:IWindowModel = null;
         var _loc6_:IWindowModel = null;
         var _loc8_:IItemListWindow = null;
         var _loc12_:ITextWindow = null;
         var _loc10_:ITextWindow = null;
         super();
         UnknownVarFromPollOfferDialog_Int_1 = param1;
         UnknownVarFromPollOfferDialog_PollWidget_1 = param4;
         var _loc11_:XmlAsset = UnknownVarFromPollOfferDialog_PollWidget_1.assets.getAssetByName("poll_offer") as XmlAsset;
         if(_loc11_ != null)
         {
            _window = UnknownVarFromPollOfferDialog_PollWidget_1.windowManager.buildFromXML(_loc11_.content as XML) as IFrameController;
            if(_window)
            {
               _window.center();
               _loc9_ = _window.findChildByName("poll_offer_button_ok");
               if(_loc9_ != null)
               {
                  _loc9_.addEventListener("WME_CLICK",onOk);
               }
               _loc5_ = _window.findChildByName("poll_offer_button_cancel");
               if(_loc5_ != null)
               {
                  _loc5_.addEventListener("WME_CLICK",onCancel);
               }
               _loc7_ = _window.findChildByName("poll_offer_button_later");
               if(_loc7_ != null)
               {
                  _loc7_.addEventListener("WME_CLICK",onLater);
               }
               _loc6_ = _window.findChildByName("header_button_close");
               if(_loc6_ != null)
               {
                  _loc6_.addEventListener("WME_CLICK",onClose);
               }
               _loc12_ = _window.findChildByName("poll_offer_headline") as ITextWindow;
               if(_loc12_)
               {
                  _loc12_.htmlText = param2;
                  _loc8_ = _window.findChildByName("poll_offer_headline_wrapper") as IItemListWindow;
                  if(_loc8_)
                  {
                     _window.height += _loc8_.scrollableRegion.height - _loc8_.visibleRegion.height;
                  }
               }
               _loc10_ = _window.findChildByName("poll_offer_summary") as ITextWindow;
               if(_loc10_)
               {
                  _loc10_.htmlText = param3;
                  _loc8_ = _window.findChildByName("poll_offer_summary_wrapper") as IItemListWindow;
                  if(_loc8_)
                  {
                     _window.height += _loc8_.scrollableRegion.height - _loc8_.visibleRegion.height;
                  }
               }
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function start() : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromPollOfferDialog_PollWidget_1 = null;
      }
      
      private function onOk(param1:WindowEvent) : void
      {
         if(_state != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         _state = "POLL_OFFER_STATE_OK";
         UnknownVarFromPollOfferDialog_PollWidget_1.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_START",UnknownVarFromPollOfferDialog_Int_1));
      }
      
      private function onCancel(param1:WindowEvent) : void
      {
         if(_state != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         _state = "POLL_OFFER_STATE_CANCEL";
         UnknownVarFromPollOfferDialog_PollWidget_1.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT",UnknownVarFromPollOfferDialog_Int_1));
         UnknownVarFromPollOfferDialog_PollWidget_1.pollCancelled(UnknownVarFromPollOfferDialog_Int_1);
      }
      
      private function onLater(param1:WindowEvent) : void
      {
         if(_state != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         _state = "POLL_OFFER_STATE_CANCEL";
         UnknownVarFromPollOfferDialog_PollWidget_1.pollCancelled(UnknownVarFromPollOfferDialog_Int_1);
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         if(_state != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         _state = "POLL_OFFER_STATE_CANCEL";
         UnknownVarFromPollOfferDialog_PollWidget_1.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT",UnknownVarFromPollOfferDialog_Int_1));
         UnknownVarFromPollOfferDialog_PollWidget_1.pollCancelled(UnknownVarFromPollOfferDialog_Int_1);
      }
   }
}

