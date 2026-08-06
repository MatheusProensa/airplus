package com.sulake.habbo.ui.widget.furniture.credit
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public class CreditFurniWidget extends RoomWidgetBase
   {
      private static const UnknownConstFromCreditFurniWidget_Number_1:Number = 100;
      
      private static const UnknownConstFromCreditFurniWidget_Number_2:Number = 100;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromCreditFurniWidget_Int_1:int = -1;
      
      private var UnknownVarFromCreditFurniWidget_Number_1:Number;
      
      private var _isNftCredit:Boolean;
      
      public function CreditFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         hideInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCFUE_CREDIT_FURNI_UPDATE",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCFUE_CREDIT_FURNI_UPDATE",onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetCreditFurniUpdateEvent) : void
      {
         hideInterface();
         UnknownVarFromCreditFurniWidget_Int_1 = param1.objectId;
         UnknownVarFromCreditFurniWidget_Number_1 = param1.creditValue;
         _isNftCredit = param1.isNftCredit;
         showInterface();
      }
      
      private function showInterface() : void
      {
         var _loc2_:IWindowModel = null;
         if(UnknownVarFromCreditFurniWidget_Int_1 == -1)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var _loc4_:String = _isNftCredit ? "nft.creditfurni.redeem.description" : "widgets.furniture.credit.redeem.value";
         var _loc5_:String = localizations.getLocalizationWithParams(_loc4_,"","value",String(UnknownVarFromCreditFurniWidget_Number_1));
         var _loc3_:String = localizations.getLocalization("nft.creditfurni.redeem.prompt");
         var _loc6_:ISoundAsset = assets.getAssetByName("credit_redeem");
         var _loc1_:XmlAsset = XmlAsset(_loc6_);
         if(_loc1_ == null)
         {
            return;
         }
         _window = windowManager.createWindow("creditfurniui_container","",4,0,131072 | 1,new Rectangle(100,100,2,2),null,0) as IWindowController_1;
         _window.buildFromXML(XML(_loc1_.content));
         _window.background = true;
         _window.color = 33554431;
         _loc2_ = _window.findChildByName("exchange_text");
         if(_loc2_ != null)
         {
            _loc2_.caption = _isNftCredit ? _loc5_ + " " + _loc3_ : _loc5_;
         }
         _loc2_ = _window.findChildByName("cancel");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByName("exchange");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByName("link");
         if(_loc2_ != null)
         {
            _loc2_.visible = !_isNftCredit;
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.procedure = onWindowClose;
         }
         _window.addEventListener("WME_CLICK",onMouseEvent);
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromCreditFurniWidget_Int_1 = -1;
         UnknownVarFromCreditFurniWidget_Number_1 = 0;
      }
      
      private function sendRedeemMessage() : void
      {
         var _loc1_:RoomWidgetCreditFurniRedeemMessage = null;
         if(UnknownVarFromCreditFurniWidget_Int_1 == -1)
         {
            return;
         }
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetCreditFurniRedeemMessage("RWFCRM_REDEEM",UnknownVarFromCreditFurniWidget_Int_1);
            messageListener.processWidgetMessage(_loc1_);
            hideInterface();
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "link":
               _loc4_ = localizations.getLocalization("widget.furni.info.url");
               if(_loc4_.indexOf("http") == 0)
               {
                  HabboWebTools.navigateToURL(_loc4_,"habboMain");
               }
               break;
            case "exchange":
               sendRedeemMessage();
               break;
            case "cancel":
            case "close":
               hideInterface();
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideInterface();
      }
   }
}

