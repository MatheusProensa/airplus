package com.sulake.habbo.roomevents.wired_trading.contracts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.contracts.WiredOpenContractMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.contracts.WiredUpdateContractMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractContentsMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractContentsMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractUpdateResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractUpdateResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredOpenContractMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredOpenContractMessageParser;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_trading.UbuntuPresetManager;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.AddEditContractElement;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.IAddEditContractElement;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.PaymentContract;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.RewardContract;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.TradeContract;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.util.AbstractContract;
   
   public class WiredContractController implements UnknownIHabboRoomeventsWired_TradingContracts1
   {
      private var _disposed:Boolean = false;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var UnknownVarFromWiredContractController_PresetManager_1:PresetManager;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromWiredContractController_Int_1:int = -1;
      
      private var UnknownVarFromWiredContractController_AddEditContractElement_1:AddEditContractElement;
      
      private var UnknownVarFromWiredContractController_PaymentContract_1:PaymentContract;
      
      private var UnknownVarFromWiredContractController_RewardContract_1:RewardContract;
      
      private var UnknownVarFromWiredContractController_TradeContract_1:TradeContract;
      
      private var _xCache:int = 2147483647;
      
      private var _yCache:int = 2147483647;
      
      public function WiredContractController(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         UnknownVarFromWiredContractController_PresetManager_1 = new UbuntuPresetManager(param1);
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new WiredOpenContractMessageEvent(onOpenContract));
         _messageEvents.push(new WiredContractContentsMessageEvent(onContractContents));
         _messageEvents.push(new WiredContractUpdateResultMessageEvent(onContractUpdateResult));
         for each(var _loc2_ in _messageEvents)
         {
            addMessageEvent(_loc2_);
         }
      }
      
      private function onOpenContract(param1:WiredOpenContractMessageEvent) : void
      {
         var _loc2_:WiredOpenContractMessageParser = param1.getParser();
         UnknownVarFromWiredContractController_Int_1 = _loc2_.contractId;
         communicationManager.connection.send(new WiredOpenContractMessageComposer(UnknownVarFromWiredContractController_Int_1));
      }
      
      private function onContractContents(param1:WiredContractContentsMessageEvent) : void
      {
         var _loc2_:WiredContractContentsMessageParser = param1.getParser();
         if(_loc2_.contractId != UnknownVarFromWiredContractController_Int_1)
         {
            return;
         }
         UnknownVarFromWiredContractController_Int_1 = -1;
         closeAllOpenFrames();
         var _loc3_:IAddEditContractElement = null;
         if(_loc2_.contractType == 0)
         {
            if(UnknownVarFromWiredContractController_PaymentContract_1 == null)
            {
               UnknownVarFromWiredContractController_PaymentContract_1 = new PaymentContract(this,UnknownVarFromWiredContractController_PresetManager_1);
            }
            UnknownVarFromWiredContractController_PaymentContract_1.show(_loc2_);
            _loc3_ = UnknownVarFromWiredContractController_PaymentContract_1;
         }
         else if(_loc2_.contractType == 1)
         {
            if(UnknownVarFromWiredContractController_TradeContract_1 == null)
            {
               UnknownVarFromWiredContractController_TradeContract_1 = new TradeContract(this,UnknownVarFromWiredContractController_PresetManager_1);
            }
            UnknownVarFromWiredContractController_TradeContract_1.show(_loc2_);
            _loc3_ = UnknownVarFromWiredContractController_TradeContract_1;
         }
         else if(_loc2_.contractType == 2)
         {
            if(UnknownVarFromWiredContractController_RewardContract_1 == null)
            {
               UnknownVarFromWiredContractController_RewardContract_1 = new RewardContract(this,UnknownVarFromWiredContractController_PresetManager_1);
            }
            UnknownVarFromWiredContractController_RewardContract_1.show(_loc2_);
            _loc3_ = UnknownVarFromWiredContractController_RewardContract_1;
         }
         if(_loc3_ != null && !(_yCache == 2147483647 || _xCache == 2147483647))
         {
            _loc3_.window.y = _yCache;
            _loc3_.window.x = _xCache;
         }
      }
      
      public function saveContract(param1:AbstractContract) : void
      {
         var _loc3_:String = param1.validate();
         if(_loc3_ != null)
         {
            _roomEvents.windowManager.alert("${wiredfurni.error.title}",_loc3_,0,null);
            return;
         }
         var _loc2_:Array = [];
         param1.addContentsToComposer(_loc2_);
         communicationManager.connection.send(new WiredUpdateContractMessageComposer(_loc2_));
      }
      
      private function onContractUpdateResult(param1:WiredContractUpdateResultMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc2_:WiredContractUpdateResultMessageParser = param1.getParser();
         if(_loc2_.isSuccess)
         {
            closeAllOpenFrames();
            return;
         }
         _loc4_ = "wiredcontracts.error." + _loc2_.failCode;
         _loc3_ = _roomEvents.localization.getLocalizationWithParams(_loc4_,_loc4_);
         _roomEvents.windowManager.alert("${wiredfurni.error.title}",_loc3_,0,null);
      }
      
      public function clear() : void
      {
         closeAllOpenFrames();
         _xCache = 2147483647;
         _yCache = 2147483647;
         if(UnknownVarFromWiredContractController_AddEditContractElement_1 != null)
         {
            UnknownVarFromWiredContractController_AddEditContractElement_1.forgetLocation();
         }
      }
      
      public function closeAllOpenFrames() : void
      {
         if(UnknownVarFromWiredContractController_AddEditContractElement_1)
         {
            UnknownVarFromWiredContractController_AddEditContractElement_1.hide();
         }
         if(UnknownVarFromWiredContractController_PaymentContract_1 && UnknownVarFromWiredContractController_PaymentContract_1.isShowing())
         {
            UnknownVarFromWiredContractController_PaymentContract_1.hide();
         }
         else if(UnknownVarFromWiredContractController_RewardContract_1 && UnknownVarFromWiredContractController_RewardContract_1.isShowing())
         {
            UnknownVarFromWiredContractController_RewardContract_1.hide();
         }
         else if(UnknownVarFromWiredContractController_TradeContract_1 && UnknownVarFromWiredContractController_TradeContract_1.isShowing())
         {
            UnknownVarFromWiredContractController_TradeContract_1.hide();
         }
      }
      
      public function cacheWindowLocation(param1:IWindowModel) : void
      {
         _yCache = param1.y;
         _xCache = param1.x;
      }
      
      public function get addEditContractElement() : AddEditContractElement
      {
         if(UnknownVarFromWiredContractController_AddEditContractElement_1 == null)
         {
            UnknownVarFromWiredContractController_AddEditContractElement_1 = new AddEditContractElement(this,UnknownVarFromWiredContractController_PresetManager_1);
         }
         return UnknownVarFromWiredContractController_AddEditContractElement_1;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _roomEvents.communication;
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!communicationManager)
         {
            return;
         }
         communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!communicationManager)
         {
            return;
         }
         communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromWiredContractController_AddEditContractElement_1 != null)
         {
            UnknownVarFromWiredContractController_AddEditContractElement_1.dispose();
            UnknownVarFromWiredContractController_AddEditContractElement_1 = null;
         }
         if(UnknownVarFromWiredContractController_TradeContract_1 != null)
         {
            UnknownVarFromWiredContractController_TradeContract_1.dispose();
            UnknownVarFromWiredContractController_TradeContract_1 = null;
         }
         if(UnknownVarFromWiredContractController_RewardContract_1 != null)
         {
            UnknownVarFromWiredContractController_RewardContract_1.dispose();
            UnknownVarFromWiredContractController_RewardContract_1 = null;
         }
         if(UnknownVarFromWiredContractController_PaymentContract_1 != null)
         {
            UnknownVarFromWiredContractController_PaymentContract_1.dispose();
            UnknownVarFromWiredContractController_PaymentContract_1 = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         UnknownVarFromWiredContractController_PresetManager_1 = null;
         _roomEvents = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

