package com.sulake.habbo.inventory.trading
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.ItemPopupCtrl;
   import com.sulake.habbo.inventory.Util;
   import com.sulake.habbo.inventory.collectibles.CollectibleGroupedItem;
   import com.sulake.habbo.inventory.items.CreditTradingItem;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class TradingView implements IInventoryView, UnknownIHabboRoom1
   {
      private static const COLOR_LOCKED:uint = 4284532064;
      
      private static const COLOR_UNLOCKED:uint = 2577770;
      
      public static const ALERT_SCAM:int = 0;
      
      public static const ALERT_OTHER_CANCELLED:int = 1;
      
      public static const ALERT_ALREADY_OPEN:int = 2;
      
      private static const TRADE_UI_SPACING:int = 7;
      
      private var UnknownVarFromTradingView_TradingModel_1:TradingModel;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var UnknownVarFromTradingView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromTradingView_ItemPopupCtrl_1:ItemPopupCtrl;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _disposed:Boolean = false;
      
      private var _visible:Boolean;
      
      private var UnknownVarFromTradingView_IWindowController_1_1:IWindowController_1;
      
      private var _windowMin:IWindowController_1;
      
      private var UnknownVarFromTradingView_Timer_1:Timer;
      
      private var UnknownVarFromTradingView_GroupItem_1:GroupItem;
      
      private var UnknownVarFromTradingView_Boolean_1:Boolean;
      
      private var _waitingSongInfo:Array = [];
      
      public function TradingView(param1:TradingModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IRoomEngine, param5:IHabboLocalizationManager, param6:IHabboSoundManagerFlash10)
      {
         super();
         UnknownVarFromTradingView_TradingModel_1 = param1;
         _windowManager = param2;
         _localization = param5;
         UnknownVarFromTradingView_IAssetLibraryCollection_1 = param3;
         _roomEngine = param4;
         _soundManager = param6;
         _visible = false;
         var _loc8_:ISoundAsset = UnknownVarFromTradingView_IAssetLibraryCollection_1.getAssetByName("item_popup_xml");
         var _loc7_:XmlAsset = XmlAsset(_loc8_);
         var _loc9_:IWindowController_1 = _windowManager.buildFromXML(_loc7_.content as XML) as IWindowController_1;
         _loc9_.visible = false;
         UnknownVarFromTradingView_ItemPopupCtrl_1 = new ItemPopupCtrl(_loc9_,UnknownVarFromTradingView_IAssetLibraryCollection_1,_windowManager,UnknownVarFromTradingView_TradingModel_1.getInventory());
         _soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public static function updateItemsGrid(param1:IItemGridWindow, param2:Map, param3:Map = null) : void
      {
         var _loc4_:GroupItem = null;
         var _loc8_:CollectibleGroupedItem = null;
         var _loc7_:IWindowController_1 = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         while(_loc6_ < param2.length)
         {
            _loc4_ = param2.getWithIndex(_loc6_) as GroupItem;
            _loc7_ = param1.getGridItemAt(_loc6_) as IWindowController_1;
            if(_loc7_)
            {
               _loc7_.id = _loc6_;
               while(_loc7_.numChildren > 0)
               {
                  _loc7_.removeChildAt(0);
               }
               _loc7_.addChild(fixItemWindow(_loc4_.window));
               _loc4_.window.id = _loc6_;
               _loc4_.removeIntervalProcedure();
            }
            _loc6_++;
         }
         if(param3 != null)
         {
            _loc5_ = int(_loc6_);
            while(_loc6_ < _loc5_ + param3.length)
            {
               _loc8_ = param3.getWithIndex(_loc6_ - _loc5_) as CollectibleGroupedItem;
               _loc7_ = param1.getGridItemAt(_loc6_) as IWindowController_1;
               if(_loc7_)
               {
                  _loc7_.id = _loc6_;
                  while(_loc7_.numChildren > 0)
                  {
                     _loc7_.removeChildAt(0);
                  }
                  _loc7_.addChild(fixItemWindow(_loc8_.window));
                  _loc8_.window.id = _loc6_;
                  _loc8_.removeIntervalProcedure();
               }
               _loc6_++;
            }
         }
         while(_loc6_ < param1.numGridItems)
         {
            _loc7_ = param1.getGridItemAt(_loc6_) as IWindowController_1;
            if(_loc7_)
            {
               _loc7_.id = _loc6_;
               _loc7_.removeChildAt(0);
               _loc7_.invalidate();
            }
            _loc6_++;
         }
      }
      
      private static function fixItemWindow(param1:IWindowController_1) : IWindowController_1
      {
         var _loc2_:int = 0;
         var _loc3_:IWindowModel = null;
         param1.height = 40;
         param1.width = 40;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            _loc3_.rectangle = new Rectangle(0,0,40,40);
            _loc2_++;
         }
         return param1;
      }
      
      public static function thumbEventProc(param1:WindowEvent, param2:IWindowModel, param3:Boolean, param4:ITradingModel, param5:Map, param6:Map, param7:Map, param8:Map, param9:ItemPopupCtrl, param10:IHabboLocalizationManager, param11:IHabboSoundManagerFlash10 = null, param12:Array = null) : void
      {
         var _loc15_:GroupItem = null;
         var _loc20_:CollectibleGroupedItem = null;
         var _loc13_:FurnitureItem = null;
         var _loc18_:int = 0;
         var _loc23_:IProductDisplayInfo = null;
         var _loc22_:String = null;
         var _loc19_:CreditTradingItem = null;
         var _loc14_:BitmapData = null;
         var _loc21_:String = null;
         var _loc17_:FurnitureItem = null;
         var _loc16_:Date = null;
         if(param3 && param1.type == "WME_CLICK")
         {
            param4.requestRemoveItemFromTrading(param2.id);
         }
         if(param1.type == "WME_OVER")
         {
            if(param3)
            {
               _loc18_ = int(param5.length);
               if(param2.id >= _loc18_ && param6 != null)
               {
                  _loc20_ = param6.getWithIndex(param2.id - _loc18_);
               }
               else
               {
                  _loc15_ = param5.getWithIndex(param2.id);
               }
            }
            else
            {
               _loc18_ = int(param7.length);
               if(param2.id >= _loc18_ && param8 != null)
               {
                  _loc20_ = param8.getWithIndex(param2.id - _loc18_);
               }
               else
               {
                  _loc15_ = param7.getWithIndex(param2.id);
               }
            }
            if(_loc20_ != null)
            {
               _loc23_ = _loc20_.renderableItem;
               _loc22_ = param4.getInventory().catalog.collectorHub.getProductName(_loc23_);
               param9.updateContent(param2 as IWindowController_1,_loc22_,null,_loc23_);
               param9.show();
               return;
            }
            if(_loc15_ == null)
            {
               return;
            }
            _loc19_ = _loc15_ as CreditTradingItem;
            if(_loc19_ != null && !param3)
            {
               param9.updateContent(param2 as IWindowController_1,_loc19_.getItemTooltipText(),_loc19_.getItemIcon(),null,null,2,false);
               param9.show();
               return;
            }
            _loc13_ = _loc15_.peek();
            if(_loc13_ == null)
            {
               return;
            }
            _loc14_ = param4.getInventory().getItemImage(_loc13_);
            if(!_loc13_.isWallItem)
            {
               _loc21_ = "${roomItem.name." + _loc13_.type + "}";
            }
            else
            {
               _loc21_ = "${wallItem.name." + _loc13_.type + "}";
            }
            if(_loc13_.category == 6)
            {
               _loc21_ = "${poster_" + _loc13_.stuffData.getLegacyString() + "_name}";
            }
            if(_loc13_.category == 10)
            {
               _loc17_ = _loc13_ as FurnitureItem;
               _loc16_ = new Date(_loc17_.creationYear,_loc17_.creationMonth - 1,_loc17_.creationDay);
               _loc21_ = param10.getLocalization("roomItem.name." + _loc13_.type) + " " + _loc16_.toLocaleDateString();
            }
            if(_loc13_.category == 8 && param11 != null && param12 != null)
            {
               _loc21_ = getTraxSongFurniName(param10,param11,param12,_loc15_,_loc21_,true,param2.id,param3);
            }
            param9.updateContent(param2 as IWindowController_1,_loc21_,_loc14_,null,_loc15_.peek().stuffData,2,isExternalImagetype(param4.getInventory(),_loc13_));
            param9.show();
         }
         else if(param1.type == "WME_OUT")
         {
            param9.hideDelayed();
         }
      }
      
      private static function isExternalImagetype(param1:HabboInventory, param2:FurnitureItem) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc3_:IFurnitureData = param1.getFurnitureData(param2.type,"i");
         return _loc3_ && _loc3_.isExternalImageType;
      }
      
      private static function getTraxSongFurniName(param1:IHabboLocalizationManager, param2:IHabboSoundManagerFlash10, param3:Array, param4:GroupItem, param5:String, param6:Boolean, param7:int = -1, param8:Boolean = false) : String
      {
         var _loc9_:IFurnitureItem = param4.peek();
         var _loc10_:ISongInfo = param2.musicController.getSongInfo(_loc9_.extra);
         if(_loc10_ != null)
         {
            param1.registerParameter("songdisc.info","name",_loc10_.name);
            param1.registerParameter("songdisc.info","author",_loc10_.creator);
            param5 = param1.getLocalization("songdisc.info");
         }
         else if(param6)
         {
            if(param3.length > 0)
            {
               param3.pop();
               param3.pop();
               param3.pop();
            }
            param3.push(param7);
            param3.push(param4);
            param3.push(param8);
            param2.musicController.requestSongInfoWithoutSamples(_loc9_.extra);
         }
         return param5;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromTradingView_IWindowController_1_1 && !UnknownVarFromTradingView_IWindowController_1_1.disposed)
            {
               UnknownVarFromTradingView_IWindowController_1_1.dispose();
               UnknownVarFromTradingView_IWindowController_1_1 = null;
            }
            if(UnknownVarFromTradingView_Timer_1)
            {
               UnknownVarFromTradingView_Timer_1.removeEventListener("timer",timerEventHandler);
               UnknownVarFromTradingView_Timer_1.stop();
               UnknownVarFromTradingView_Timer_1 = null;
            }
            if(UnknownVarFromTradingView_ItemPopupCtrl_1 != null)
            {
               UnknownVarFromTradingView_ItemPopupCtrl_1.dispose();
               UnknownVarFromTradingView_ItemPopupCtrl_1 = null;
            }
            if(_soundManager)
            {
               if(_soundManager.events != null)
               {
                  _soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
               }
               _soundManager = null;
            }
            _waitingSongInfo = null;
            UnknownVarFromTradingView_TradingModel_1 = null;
            _windowManager = null;
            _roomEngine = null;
            _localization = null;
            UnknownVarFromTradingView_IAssetLibraryCollection_1 = null;
            UnknownVarFromTradingView_GroupItem_1 = null;
            _visible = false;
            _disposed = true;
         }
      }
      
      public function setup(param1:int, param2:Boolean, param3:int, param4:Boolean) : void
      {
         setMinimized(false);
         hideOwnUserNotification();
         hideOtherUserNotification();
         if(!param2 && !param4)
         {
            showInfoMessage("${inventory.trading.warning.both_accounts_disabled}");
            showOwnUserNotification("");
            showOtherUserNotification("");
         }
         else
         {
            if(!param2)
            {
               showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
            }
            if(!param4)
            {
               showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
            }
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(UnknownVarFromTradingView_IWindowController_1_1 == null)
         {
            UnknownVarFromTradingView_IWindowController_1_1 = createNormalWindow();
            showHighlightInfo(null);
         }
         if(_windowMin == null)
         {
            _windowMin = createMinimizedWindow();
         }
         if(!UnknownVarFromTradingView_Boolean_1)
         {
            resizeWindow(true);
            return UnknownVarFromTradingView_IWindowController_1_1;
         }
         return _windowMin;
      }
      
      public function setMinimized(param1:Boolean = false) : void
      {
         UnknownVarFromTradingView_Boolean_1 = param1;
      }
      
      public function updateItemList(param1:int) : void
      {
         var _loc4_:* = false;
         if(!UnknownVarFromTradingView_IWindowController_1_1)
         {
            return;
         }
         _loc4_ = param1 == UnknownVarFromTradingView_TradingModel_1.otherUserId;
         var _loc3_:Map = _loc4_ ? UnknownVarFromTradingView_TradingModel_1.otherUserItems : UnknownVarFromTradingView_TradingModel_1.ownUserItems;
         var _loc5_:Map = _loc4_ ? UnknownVarFromTradingView_TradingModel_1.otherUserNftItems : UnknownVarFromTradingView_TradingModel_1.ownUserNftItems;
         var _loc2_:IItemGridWindow = _loc4_ ? getOtherUsersItemGrid() : getOwnUsersItemGrid();
         updateItemsGrid(_loc2_,_loc3_,_loc5_);
         updateActionState();
      }
      
      public function clearItemLists() : void
      {
         var _loc3_:IWindowController_1 = null;
         var _loc2_:* = 0;
         var _loc1_:IItemGridWindow = null;
         _loc1_ = getOwnUsersItemGrid();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.numGridItems)
         {
            _loc3_ = _loc1_.getGridItemAt(_loc2_) as IWindowController_1;
            if(_loc3_)
            {
               _loc3_.id = _loc2_;
               _loc3_.removeChildAt(0);
            }
            _loc2_++;
         }
         _loc1_ = getOtherUsersItemGrid();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.numGridItems)
         {
            _loc3_ = _loc1_.getGridItemAt(_loc2_) as IWindowController_1;
            if(_loc3_)
            {
               _loc3_.id = _loc2_;
               _loc3_.removeChildAt(0);
            }
            _loc2_++;
         }
      }
      
      public function updateUserInterface() : void
      {
         var _loc2_:ITextWindow = null;
         var _loc1_:IStaticBitmapWrapperWindow = null;
         if(UnknownVarFromTradingView_IWindowController_1_1)
         {
            updateActionState();
            _loc2_ = UnknownVarFromTradingView_IWindowController_1_1.findChildByTag("OTHER_USER_NAME") as ITextWindow;
            if(_loc2_)
            {
               _loc2_.text = UnknownVarFromTradingView_TradingModel_1.otherUserName;
            }
            _loc1_ = UnknownVarFromTradingView_IWindowController_1_1.findChildByTag("OWN_USER_LOCK") as IStaticBitmapWrapperWindow;
            if(_loc1_)
            {
               _loc1_.assetUri = UnknownVarFromTradingView_TradingModel_1.ownUserAccepts ? "inventory_trading_trading_locked_icon" : "inventory_trading_trading_unlocked_icon";
            }
            _loc1_ = UnknownVarFromTradingView_IWindowController_1_1.findChildByTag("OTHER_USER_LOCK") as IStaticBitmapWrapperWindow;
            if(_loc1_)
            {
               _loc1_.assetUri = UnknownVarFromTradingView_TradingModel_1.otherUserAccepts ? "inventory_trading_trading_locked_icon" : "inventory_trading_trading_unlocked_icon";
            }
         }
      }
      
      public function updateActionState() : void
      {
         var _loc1_:IWindowModel = null;
         var _loc2_:IWindowModel = null;
         if(UnknownVarFromTradingView_IWindowController_1_1)
         {
            _loc1_ = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("button_accept");
            _loc2_ = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("button_cancel");
            if(UnknownVarFromTradingView_TradingModel_1.getInventory().getBoolean("trading.warning.enabled"))
            {
               if(UnknownVarFromTradingView_TradingModel_1.isCreditFurniPresent())
               {
                  showHighlightInfo(_localization.getLocalization("inventory.trading.warning.credits","inventory.trading.warning.credits"));
               }
               else
               {
                  showHighlightInfo(null);
               }
            }
            showSilverFeeInfo(UnknownVarFromTradingView_TradingModel_1.requiredSilverFee,UnknownVarFromTradingView_TradingModel_1.playerSilver,UnknownVarFromTradingView_TradingModel_1.otherPlayerSilver);
            showOwnOfferInfo(UnknownVarFromTradingView_TradingModel_1.ownUserNumItemsTotal,UnknownVarFromTradingView_TradingModel_1.ownUserNumCredits);
            showOtherOfferInfo(UnknownVarFromTradingView_TradingModel_1.otherUserNumItemsTotal,UnknownVarFromTradingView_TradingModel_1.otherUserNumCredits);
            switch(int(UnknownVarFromTradingView_TradingModel_1.state))
            {
               case 0:
                  if((UnknownVarFromTradingView_TradingModel_1.otherHasAnyOffer || UnknownVarFromTradingView_TradingModel_1.ownHasAnyOffer) && UnknownVarFromTradingView_TradingModel_1.tradeFeeReached())
                  {
                     _loc1_.enable();
                  }
                  else
                  {
                     _loc1_.disable();
                  }
                  _loc1_.caption = "${inventory.trading.accept}";
                  break;
               case 1:
                  if((UnknownVarFromTradingView_TradingModel_1.otherHasAnyOffer || UnknownVarFromTradingView_TradingModel_1.ownHasAnyOffer) && UnknownVarFromTradingView_TradingModel_1.tradeFeeReached())
                  {
                     _loc1_.enable();
                  }
                  else
                  {
                     _loc1_.disable();
                  }
                  _loc1_.caption = UnknownVarFromTradingView_TradingModel_1.ownUserAccepts ? "${inventory.trading.modify}" : "${inventory.trading.accept}";
                  showInfoMessage("${inventory.trading.info.add}");
                  break;
               case 2:
                  _loc1_.disable();
                  _loc1_.caption = "${inventory.trading.countdown}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 3:
                  _loc1_.enable();
                  _loc1_.caption = "${inventory.trading.confirm}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 4:
                  _loc1_.disable();
                  showInfoMessage("${inventory.trading.info.waiting}");
                  break;
               case 5:
                  _loc1_.disable();
                  _loc1_.caption = "${inventory.trading.accept}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 6:
                  break;
               default:
                  throw new Error("Unknown trading progress state: \"" + UnknownVarFromTradingView_TradingModel_1.state + "\"");
            }
            Util.disableButton(_loc2_,UnknownVarFromTradingView_TradingModel_1.isConfirmingWeb3Trade());
         }
      }
      
      public function showInfoMessage(param1:String) : void
      {
         var _loc2_:ITextWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("help_text") as ITextWindow;
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      private function showHighlightInfo(param1:String) : void
      {
         if(!UnknownVarFromTradingView_IWindowController_1_1)
         {
            return;
         }
         var _loc3_:IWindowModel = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("info_border_highlighted");
         if(_loc3_)
         {
            _loc3_.visible = param1 != null;
         }
         var _loc2_:ITextWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("info_text_highlighted") as ITextWindow;
         if(_loc2_)
         {
            _loc2_.visible = param1 != null;
            if(param1)
            {
               _loc2_.text = param1;
            }
         }
         resizeWindow();
      }
      
      private function showSilverFeeInfo(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:String = null;
         silverFeeContainer.visible = UnknownVarFromTradingView_TradingModel_1.isWeb3Trade();
         yourSilver.text = String(param2);
         otherSilver.text = String(param3);
         var _loc6_:int = param2 + param3;
         var _loc7_:String = param1 <= _loc6_ ? "000000" : "AC232A";
         silverProgress.text = "<font color=\"#" + _loc7_ + "\">" + _loc6_ + "</font>/" + param1;
         var _loc5_:Boolean = UnknownVarFromTradingView_TradingModel_1.state == 0 || UnknownVarFromTradingView_TradingModel_1.state == 1;
         Util.disableButton(feeMinusButton,param2 <= 0 || !_loc5_);
         Util.disableButton(feePlusButton,param2 + param3 >= param1 || param2 >= UnknownVarFromTradingView_TradingModel_1.getInventory().catalog.getPurse().silverBalance || !_loc5_);
         if(UnknownVarFromTradingView_TradingModel_1.isWeb3Trade())
         {
            _loc4_ = param1 <= 0 ? "inventory.trading.note_silver_fee_free_temporarily" : "inventory.trading.note_silver_fee";
            silverFeeInfoText.text = _localization.getLocalization(_loc4_);
         }
         resizeWindow();
      }
      
      private function resizeWindow(param1:Boolean = true) : void
      {
         Util.moveAllChildrenToColumn(UnknownVarFromTradingView_IWindowController_1_1,7,!param1);
         UnknownVarFromTradingView_IWindowController_1_1.height = Util.getLowestPoint(UnknownVarFromTradingView_IWindowController_1_1);
         UnknownVarFromTradingView_TradingModel_1.getInventory().view.resizeToFitContents();
      }
      
      private function showOwnOfferInfo(param1:int, param2:int) : void
      {
         showOfferInfo("content_text_1_a",param1,"content_text_1_b",param2,true);
      }
      
      private function showOtherOfferInfo(param1:int, param2:int) : void
      {
         showOfferInfo("content_text_2_a",param1,"content_text_2_b",param2,false);
      }
      
      private function showOfferInfo(param1:String, param2:int, param3:String, param4:int, param5:Boolean) : void
      {
         var _loc6_:ITextWindow = null;
         if(!UnknownVarFromTradingView_TradingModel_1.getInventory().getBoolean("trading.warning.enabled"))
         {
            return;
         }
         _loc6_ = UnknownVarFromTradingView_IWindowController_1_1.findChildByName(param1) as ITextWindow;
         if(_loc6_)
         {
            _localization.registerParameter("inventory.trading.info.itemcount","value",param2.toString());
            _loc6_.text = _localization.getLocalization("inventory.trading.info.itemcount");
         }
         _loc6_ = UnknownVarFromTradingView_IWindowController_1_1.findChildByName(param3) as ITextWindow;
         if(_loc6_)
         {
            _localization.registerParameter("inventory.trading.info.creditvalue","value",param4.toString());
            _loc6_.text = _localization.getLocalization("inventory.trading.info.creditvalue");
         }
      }
      
      public function showOwnUserNotification(param1:String) : void
      {
         var _loc3_:ITextWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("info_text_0") as ITextWindow;
         _loc3_.text = param1;
         _loc3_.visible = true;
         var _loc2_:IItemGridWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("item_grid_0") as IItemGridWindow;
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function hideOwnUserNotification() : void
      {
         var _loc2_:ITextWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("info_text_0") as ITextWindow;
         _loc2_.visible = false;
         var _loc1_:IItemGridWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("item_grid_0") as IItemGridWindow;
         if(_loc1_)
         {
            _loc1_.visible = true;
         }
      }
      
      public function showOtherUserNotification(param1:String) : void
      {
         var _loc3_:ITextWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("info_text_1") as ITextWindow;
         _loc3_.text = param1;
         _loc3_.visible = true;
         var _loc2_:IItemGridWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("item_grid_1") as IItemGridWindow;
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function hideOtherUserNotification() : void
      {
         var _loc2_:ITextWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("info_text_1") as ITextWindow;
         _loc2_.visible = false;
         var _loc1_:IItemGridWindow = UnknownVarFromTradingView_IWindowController_1_1.findChildByName("item_grid_1") as IItemGridWindow;
         if(_loc1_)
         {
            _loc1_.visible = true;
         }
      }
      
      public function alertTradeOpenFailed(param1:TradeOpenFailedEvent) : void
      {
         var _loc2_:String = "inventory.trading.openfail." + param1.getParser().reason;
         _windowManager.registerLocalizationParameter(_loc2_,"otherusername",param1.getParser().otherUserName);
         _windowManager.simpleAlert("${inventory.trading.openfail.title}","${inventory.trading.openfail.caption}","${" + _loc2_ + "}");
      }
      
      public function alertPopup(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.warning.other_not_offering}",0,onTradingAlert);
               break;
            case 1:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.info.closed}",0,onTradingAlert);
               break;
            case 2:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.info.already_open}",0,onTradingAlert);
         }
      }
      
      public function showAlertNotification(param1:String, param2:String, param3:Function) : void
      {
         var title:String = param1;
         var description:String = param2;
         var callback:Function = param3;
         _windowManager.alert(title,description,0,callback ?? function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      public function startConfirmCountdown() : void
      {
         if(UnknownVarFromTradingView_Timer_1 == null)
         {
            UnknownVarFromTradingView_Timer_1 = new Timer(1000,3);
            UnknownVarFromTradingView_Timer_1.addEventListener("timer",timerEventHandler);
         }
         UnknownVarFromTradingView_Timer_1.reset();
         UnknownVarFromTradingView_Timer_1.repeatCount = 3;
         UnknownVarFromTradingView_Timer_1.start();
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter","3");
         updateUserInterface();
      }
      
      public function cancelConfirmCountdown() : void
      {
         if(UnknownVarFromTradingView_Timer_1 != null)
         {
            UnknownVarFromTradingView_Timer_1.reset();
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc4_:GroupItem = null;
         var _loc6_:Map = null;
         var _loc3_:Boolean = false;
         var _loc5_:* = 0;
         _loc6_ = UnknownVarFromTradingView_TradingModel_1.ownUserItems;
         _loc3_ = false;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = _loc6_.getWithIndex(_loc5_) as GroupItem;
            if(_loc4_.iconCallbackId == param1)
            {
               _loc4_.iconImage = param2;
               _loc3_ = true;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            updateItemList(UnknownVarFromTradingView_TradingModel_1.ownUserId);
         }
         _loc6_ = UnknownVarFromTradingView_TradingModel_1.otherUserItems;
         _loc3_ = false;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = _loc6_[_loc5_] as GroupItem;
            if(_loc4_.iconCallbackId == param1)
            {
               _loc4_.iconImage = param2;
               _loc3_ = true;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            updateItemList(UnknownVarFromTradingView_TradingModel_1.otherUserId);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function setSelection(param1:GroupItem) : void
      {
         removeSelection();
         if(param1)
         {
            UnknownVarFromTradingView_GroupItem_1 = param1;
            UnknownVarFromTradingView_GroupItem_1.isSelected = true;
         }
      }
      
      public function removeSelection() : void
      {
         if(UnknownVarFromTradingView_GroupItem_1)
         {
            UnknownVarFromTradingView_GroupItem_1.isSelected = false;
            UnknownVarFromTradingView_GroupItem_1 = null;
         }
      }
      
      public function onTradingAlert(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            param1.dispose();
         }
      }
      
      protected function getOwnUsersItemGrid() : IItemGridWindow
      {
         return UnknownVarFromTradingView_IWindowController_1_1.findChildByTag("OWN_USER_GRID") as IItemGridWindow;
      }
      
      protected function getOtherUsersItemGrid() : IItemGridWindow
      {
         return UnknownVarFromTradingView_IWindowController_1_1.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
      }
      
      private function createNormalWindow() : IWindowController_1
      {
         var _loc2_:IWindowModel = null;
         var _loc3_:* = null;
         var _loc5_:* = 0;
         var _loc4_:IItemGridWindow = null;
         var _loc1_:XML = XmlAsset(UnknownVarFromTradingView_IAssetLibraryCollection_1.getAssetByName("inventory_trading_xml")).content as XML;
         var _loc6_:IWindowController_1 = _windowManager.buildFromXML(_loc1_) as IWindowController_1;
         _loc4_ = _loc6_.findChildByTag("OWN_USER_GRID") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.numGridItems)
         {
            _loc2_ = _loc4_.getGridItemAt(_loc5_);
            _loc2_.id = _loc5_;
            _loc2_.procedure = ownThumbEventProc;
            _loc2_.addEventListener("WME_OVER",ownThumbEventProc);
            _loc2_.addEventListener("WME_OUT",ownThumbEventProc);
            _loc5_++;
         }
         _loc4_ = _loc6_.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.numGridItems)
         {
            _loc2_ = _loc4_.getGridItemAt(_loc5_);
            _loc2_.id = _loc5_;
            _loc2_.procedure = othersThumbEventProc;
            _loc2_.addEventListener("WME_OVER",othersThumbEventProc);
            _loc2_.addEventListener("WME_OUT",othersThumbEventProc);
            _loc5_++;
         }
         _loc6_.procedure = windowEventProc;
         return _loc6_;
      }
      
      private function createMinimizedWindow() : IWindowController_1
      {
         var _loc1_:XML = XmlAsset(UnknownVarFromTradingView_IAssetLibraryCollection_1.getAssetByName("inventory_trading_minimized_xml")).content as XML;
         var _loc2_:IWindowController_1 = _windowManager.buildFromXML(_loc1_) as IWindowController_1;
         _loc2_.procedure = windowMininizedEventProc;
         return _loc2_;
      }
      
      private function windowMininizedEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_continue":
                  UnknownVarFromTradingView_TradingModel_1.requestFurniViewOpen();
                  break;
               case "button_cancel":
                  UnknownVarFromTradingView_TradingModel_1.requestCancelTrading();
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_accept":
                  switch(int(UnknownVarFromTradingView_TradingModel_1.state) - 1)
                  {
                     case 0:
                        if(UnknownVarFromTradingView_TradingModel_1.otherUserItems.length == 0 && UnknownVarFromTradingView_TradingModel_1.otherUserNftItems.length == 0 && !UnknownVarFromTradingView_TradingModel_1.ownUserAccepts)
                        {
                           alertPopup(0);
                        }
                        if(UnknownVarFromTradingView_TradingModel_1.ownUserAccepts)
                        {
                           UnknownVarFromTradingView_TradingModel_1.requestUnacceptTrading();
                        }
                        else
                        {
                           UnknownVarFromTradingView_TradingModel_1.requestAcceptTrading();
                        }
                        break;
                     case 2:
                        param2.disable();
                        UnknownVarFromTradingView_TradingModel_1.requestConfirmAcceptTrading();
                  }
                  break;
               case "button_cancel":
                  switch(int(UnknownVarFromTradingView_TradingModel_1.state) - 1)
                  {
                     case 0:
                        UnknownVarFromTradingView_TradingModel_1.requestCancelTrading();
                        break;
                     case 2:
                        UnknownVarFromTradingView_TradingModel_1.requestConfirmDeclineTrading();
                  }
                  break;
               case "silver_minus_button":
                  UnknownVarFromTradingView_TradingModel_1.addSilverFee(false);
                  break;
               case "silver_plus_button":
                  UnknownVarFromTradingView_TradingModel_1.addSilverFee(true);
            }
         }
      }
      
      private function ownThumbEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         thumbEventProc(param1,param2,true,UnknownVarFromTradingView_TradingModel_1,UnknownVarFromTradingView_TradingModel_1.ownUserItems,UnknownVarFromTradingView_TradingModel_1.ownUserNftItems,UnknownVarFromTradingView_TradingModel_1.otherUserItems,UnknownVarFromTradingView_TradingModel_1.otherUserNftItems,UnknownVarFromTradingView_ItemPopupCtrl_1,_localization,_soundManager,_waitingSongInfo);
      }
      
      private function othersThumbEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         thumbEventProc(param1,param2,false,UnknownVarFromTradingView_TradingModel_1,UnknownVarFromTradingView_TradingModel_1.ownUserItems,UnknownVarFromTradingView_TradingModel_1.ownUserNftItems,UnknownVarFromTradingView_TradingModel_1.otherUserItems,UnknownVarFromTradingView_TradingModel_1.otherUserNftItems,UnknownVarFromTradingView_ItemPopupCtrl_1,_localization,_soundManager,_waitingSongInfo);
      }
      
      private function timerEventHandler(param1:TimerEvent) : void
      {
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter",String(3 - UnknownVarFromTradingView_Timer_1.currentCount));
         if(UnknownVarFromTradingView_Timer_1.currentCount == 3)
         {
            UnknownVarFromTradingView_TradingModel_1.confirmCountdownReady();
            UnknownVarFromTradingView_Timer_1.reset();
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc8_:Boolean = false;
         var _loc6_:GroupItem = null;
         var _loc7_:* = 0;
         var _loc3_:FurnitureItem = null;
         var _loc4_:String = null;
         var _loc5_:BitmapData = null;
         var _loc2_:IWindowModel = null;
         if(_waitingSongInfo.length > 0)
         {
            _loc8_ = Boolean(_waitingSongInfo.pop());
            _loc6_ = _waitingSongInfo.pop();
            _loc7_ = uint(_waitingSongInfo.pop());
            _loc3_ = _loc6_.peek();
            if(_loc3_.extra == param1.id)
            {
               if(_loc8_ && UnknownVarFromTradingView_TradingModel_1.ownUserItems.getWithIndex(_loc7_) == _loc6_ || !_loc8_ && UnknownVarFromTradingView_TradingModel_1.otherUserItems.getWithIndex(_loc7_) == _loc6_)
               {
                  _loc4_ = getTraxSongFurniName(_localization,_soundManager,_waitingSongInfo,_loc6_,"",false);
                  _loc5_ = UnknownVarFromTradingView_TradingModel_1.getInventory().getItemImage(_loc3_);
                  _loc2_ = _loc8_ ? getOwnUsersItemGrid().getGridItemAt(_loc7_) : getOtherUsersItemGrid().getGridItemAt(_loc7_);
                  UnknownVarFromTradingView_ItemPopupCtrl_1.updateContent(_loc2_ as IWindowController_1,_loc4_,_loc5_);
               }
            }
            else
            {
               _waitingSongInfo.push(_loc7_);
               _waitingSongInfo.push(_loc6_);
               _waitingSongInfo.push(_loc8_);
            }
         }
      }
      
      private function get silverFeeContainer() : IWindowController_1
      {
         return UnknownVarFromTradingView_IWindowController_1_1.findChildByName("silver_container") as IWindowController_1;
      }
      
      private function get yourSilver() : ITextWindow
      {
         return silverFeeContainer.findChildByName("your_silver") as ITextWindow;
      }
      
      private function get otherSilver() : ITextWindow
      {
         return silverFeeContainer.findChildByName("other_silver") as ITextWindow;
      }
      
      private function get silverProgress() : IHTMLTextController
      {
         return silverFeeContainer.findChildByName("silver_progress_html") as IHTMLTextController;
      }
      
      private function get feeMinusButton() : IIconButtonWindow
      {
         return silverFeeContainer.findChildByName("silver_minus_button") as IIconButtonWindow;
      }
      
      private function get feePlusButton() : IIconButtonWindow
      {
         return silverFeeContainer.findChildByName("silver_plus_button") as IIconButtonWindow;
      }
      
      private function get silverFeeInfoText() : ITextWindow
      {
         return silverFeeContainer.findChildByName("silver_fee_info_text") as ITextWindow;
      }
   }
}

