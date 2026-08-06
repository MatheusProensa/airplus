package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests.CoinsChestContentsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.WithdrawCoinsFromChestMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.CoinsChestContentsMessageParser;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_trading.chests.IWiredChestController_2;
   import com.sulake.habbo.roomevents.wired_trading.chests.UnknownHabboRoomeventsWired_TradingChests1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class CoinChestSubController extends AbstractChestSubController
   {
      public static const DARK_THEME_CHEST_NAMES:Array = ["wf_storage_coins1"];
      
      private static const CHEST_STATES:Map = initChestStates();
      
      private var _view:IWindowController_1;
      
      private var _itemCount:int;
      
      private var _chestState:String;
      
      private var UnknownVarFromCoinChestSubController_String_1:String;
      
      private var _classNameCache:String;
      
      public function CoinChestSubController(param1:IWiredChestController_2)
      {
         super(param1);
         _view = roomEvents.getXmlWindow("coins_chest_contents") as IWindowController_1;
         addMessageEvent(new CoinsChestContentsMessageEvent(onCoinsMessage));
         withdrawInput.restrict = "0-9";
         withdrawButton.addEventListener("WME_CLICK",onWithdrawClick);
      }
      
      private static function initChestStates() : Map
      {
         var _loc1_:Map = new Map();
         _loc1_.add(0,"zero");
         _loc1_.add(1,"low");
         _loc1_.add(20,"medium");
         _loc1_.add(100,"high");
         return _loc1_;
      }
      
      private function onWithdrawClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:Number = parseInt(withdrawInput.text);
         if(isNaN(_loc2_))
         {
            return;
         }
         parentController.send(new WithdrawCoinsFromChestMessageComposer(viewingChestId,int(_loc2_)));
      }
      
      private function onCoinsMessage(param1:CoinsChestContentsMessageEvent) : void
      {
         var _loc2_:CoinsChestContentsMessageParser = param1.getParser();
         var _loc3_:int = _loc2_.chestId;
         if(_loc2_.isUpdate)
         {
            if(parentController.activeChestId != _loc3_)
            {
               return;
            }
            _itemCount = _loc2_.coins;
         }
         else
         {
            if(parentController.requestedChestId != _loc3_)
            {
               return;
            }
            _itemCount = _loc2_.coins;
            _chestState = CHEST_STATES.getValue(0);
            _classNameCache = null;
            parentController.setOpenStatus(_loc3_,this);
         }
         coinAmountText.text = String(_loc2_.coins);
         balanceContainerList.x = balanceContainerList.parent.width / 2 - balanceContainerList.width / 2;
         _chestState = CHEST_STATES.getValue(0);
         for each(var _loc4_ in CHEST_STATES.getKeys())
         {
            if(_loc2_.coins >= _loc4_)
            {
               _chestState = CHEST_STATES.getValue(_loc4_);
            }
         }
         backgroundImage.assetUri = "wired_chests_images_" + UnknownVarFromCoinChestSubController_String_1 + "_coins_chest_balance_" + _chestState;
         wrapperView.updateUI();
      }
      
      override public function get type() : int
      {
         return UnknownHabboRoomeventsWired_TradingChests1.TYPE_COIN;
      }
      
      override public function get title() : String
      {
         return localize("wiredchests.coin_chest");
      }
      
      override public function get view() : IWindowController_1
      {
         return _view;
      }
      
      override public function get isEmpty() : Boolean
      {
         return _itemCount <= 0;
      }
      
      override public function get itemCount() : int
      {
         return _itemCount;
      }
      
      override public function clear() : void
      {
         _itemCount = 0;
         super.clear();
      }
      
      override public function updateUI() : void
      {
         Util.disableSection(withdrawButton,!canWithdraw || isEmpty);
         UnknownVarFromCoinChestSubController_String_1 = DARK_THEME_CHEST_NAMES.indexOf(className) != -1 ? "dark" : "light";
         backgroundImage.assetUri = "wired_chests_images_" + UnknownVarFromCoinChestSubController_String_1 + "_coins_chest_balance_" + _chestState;
      }
      
      public function get className() : String
      {
         if(_classNameCache != null)
         {
            return _classNameCache;
         }
         if(wrapperView.viewingChestFurni == null)
         {
            _classNameCache = "";
            return _classNameCache;
         }
         var _loc2_:int = wrapperView.viewingChestFurni.getModel().getNumber("furniture_type_id");
         var _loc1_:IFurnitureData = parentController.sessionDataManager.getFloorItemData(_loc2_);
         if(_loc1_ == null)
         {
            _classNameCache = "";
            return _classNameCache;
         }
         _classNameCache = _loc1_.className;
         return _classNameCache;
      }
      
      override public function get allowResizing() : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _view.dispose();
         _view = null;
         super.dispose();
      }
      
      private function get balanceText() : ITextWindow
      {
         return _view.findChildByName("balance_txt") as ITextWindow;
      }
      
      private function get coinAmountText() : ITextWindow
      {
         return _view.findChildByName("coins_amount_txt") as ITextWindow;
      }
      
      private function get balanceContainerList() : IItemListWindow
      {
         return _view.findChildByName("balance_container") as IItemListWindow;
      }
      
      private function get backgroundImage() : IStaticBitmapWrapperWindow
      {
         return _view.findChildByName("bg_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get withdrawInput() : ITextFieldWindow
      {
         return _view.findChildByName("withdraw_input") as ITextFieldWindow;
      }
      
      private function get withdrawButton() : UnknownICoreWindowComponents4
      {
         return _view.findChildByName("withdraw_btn") as UnknownICoreWindowComponents4;
      }
   }
}

