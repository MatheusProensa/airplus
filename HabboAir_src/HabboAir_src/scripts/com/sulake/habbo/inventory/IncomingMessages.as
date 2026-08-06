package com.sulake.habbo.inventory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgePointLimitsEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeReceivedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotAddedToInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotRemovedFromInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.clothes.FigureSetIdsEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListAddOrUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveMultipleEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.GoToBreedingNestFailureEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetAddedToInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetRemovedFromInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverFeeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverSetMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade.WiredTradeCancelledMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade.WiredTradeCompletedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade.WiredTradeInitiateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade.WiredTradeItemsUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.SelectedBadgeData;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftAssetInventoryMessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftAssetInventoryMessageParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftAssetsMessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftAssetsMessageParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftItem;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeAndPointLimit;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeReceivedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotAddedToInventoryParser;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotInventoryMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotRemovedFromInventoryParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveMultipleParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.UnknownHabboCommunicationMessagesParserInventoryFurni1;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeOpenFailedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResultParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.WiredTradeCancelledMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.WiredTradeInitiateMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.WiredTradeItemsUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.TradeRequirement;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.inventory.bots.BotsModel;
   import com.sulake.habbo.inventory.collectibles.CollectibleGroupedItem;
   import com.sulake.habbo.inventory.collectibles.CollectiblesModel;
   import com.sulake.habbo.inventory.effects.Effect;
   import com.sulake.habbo.inventory.effects.EffectsModel;
   import com.sulake.habbo.inventory.events.HabboInventoryFurniListParsedEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.inventory.pets.PetsModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.inventory.wired_trading.WiredTradingModel;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class IncomingMessages
   {
      private static const GROUPED_FURNI_TYPE:String = "credit_groupitem_type_id";
      
      private var _inventory:HabboInventory;
      
      private var _com:IHabboCommunicationManager;
      
      private var UnknownVarFromIncomingMessages_Vector_1:Vector.<Map>;
      
      private var UnknownVarFromIncomingMessages_Vector_2:Vector.<Map>;
      
      private var UnknownVarFromIncomingMessages_Vector_3:Vector.<Map>;
      
      private var UnknownVarFromIncomingMessages_Vector_4:Vector.<Map>;
      
      private var UnknownVarFromIncomingMessages_Int_1:int;
      
      public function IncomingMessages(param1:HabboInventory)
      {
         super();
         _inventory = param1;
         _com = _inventory.communication;
         _com.addHabboConnectionMessageEvent(new TradingNotOpenEvent(onTradingNotOpen,TradingNotOpenParser));
         _com.addHabboConnectionMessageEvent(new TradeOpenFailedEvent(onTradingOpenFailed,TradeOpenFailedParser));
         _com.addHabboConnectionMessageEvent(new FurniListInvalidateEvent(onFurniListInvalidate));
         _com.addHabboConnectionMessageEvent(new FurniListAddOrUpdateEvent(onFurnitureAddOrUpdate));
         _com.addHabboConnectionMessageEvent(new PetInventoryEvent(onPets));
         _com.addHabboConnectionMessageEvent(new OpenConnectionMessageEvent(onRoomLeft));
         _com.addHabboConnectionMessageEvent(new NotEnoughBalanceMessageEvent(onNotEnoughCredits));
         _com.addHabboConnectionMessageEvent(new FurniListRemoveEvent(onFurniListRemove));
         _com.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementReceived));
         _com.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onClubStatus));
         _com.addHabboConnectionMessageEvent(new PostItPlacedEvent(onPostItPlaced));
         _com.addHabboConnectionMessageEvent(new TradeNftAssetInventoryMessageEvent(onCollectibles));
         _com.addHabboConnectionMessageEvent(new TradeSilverSetMessageEvent(onTradeSilverSet));
         _com.addHabboConnectionMessageEvent(new BotInventoryEvent(onBots));
         _com.addHabboConnectionMessageEvent(new WiredTradeInitiateMessageEvent(onWiredTradeInitiate));
         _com.addHabboConnectionMessageEvent(new PetRemovedFromInventoryEvent(onPetRemoved));
         _com.addHabboConnectionMessageEvent(new FigureSetIdsEvent(onFigureSetIds));
         _com.addHabboConnectionMessageEvent(new WiredTradeCancelledMessageEvent(onWiredTradeCancelled));
         _com.addHabboConnectionMessageEvent(new FurniListEvent(onFurniList));
         _com.addHabboConnectionMessageEvent(new MarketplaceItemStatsEvent(onMarketplaceItemStats));
         _com.addHabboConnectionMessageEvent(new TradingCloseEvent(onTradingClose,TradingCloseParser));
         _com.addHabboConnectionMessageEvent(new MarketplaceConfigurationEvent(onMarketplaceConfiguration));
         _com.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
         _com.addHabboConnectionMessageEvent(new WiredTradeCompletedMessageEvent(onWiredTradeCompleted));
         _com.addHabboConnectionMessageEvent(new WiredTradeItemsUpdateMessageEvent(onWiredTradeItemsUpdate));
         _com.addHabboConnectionMessageEvent(new HabboUserBadgesMessageEvent(onUserBadges));
         _com.addHabboConnectionMessageEvent(new PetAddedToInventoryEvent(onPetAdded));
         _com.addHabboConnectionMessageEvent(new BadgesEvent(onBadges));
         _com.addHabboConnectionMessageEvent(new AvatarEffectExpiredMessageEvent(onAvatarEffectExpired));
         _com.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         _com.addHabboConnectionMessageEvent(new MarketplaceCanMakeOfferResult(onMarketplaceCanMakeOfferResult));
         _com.addHabboConnectionMessageEvent(new AchievementsScoreEvent(onAchievementsScore));
         _com.addHabboConnectionMessageEvent(new FurniListRemoveMultipleEvent(onFurniListRemoveMultiple));
         _com.addHabboConnectionMessageEvent(new MarketplaceMakeOfferResult(onMarketplaceMakeOfferResult));
         _com.addHabboConnectionMessageEvent(new TradingItemListEvent(onTradingItemList,TradingItemListParser));
         _com.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         _com.addHabboConnectionMessageEvent(new TradingOtherNotAllowedEvent(onTradingOtherNotAllowed,TradingOtherNotAllowedParser));
         _com.addHabboConnectionMessageEvent(new TradingAcceptEvent(onTradingAccepted,TradingAcceptParser));
         _com.addHabboConnectionMessageEvent(new BotAddedToInventoryEvent(onBotAdded));
         _com.addHabboConnectionMessageEvent(new AvatarEffectsMessageEvent(onAvatarEffects));
         _com.addHabboConnectionMessageEvent(new GoToBreedingNestFailureEvent(onGoToBreedingNestFailure));
         _com.addHabboConnectionMessageEvent(new TradingCompletedEvent(onTradingCompleted,TradingCompletedParser));
         _com.addHabboConnectionMessageEvent(new AvatarEffectAddedMessageEvent(onAvatarEffectAdded));
         _com.addHabboConnectionMessageEvent(new TradingConfirmationEvent(onTradingConfirmation,TradingConfirmationParser));
         _com.addHabboConnectionMessageEvent(new AvatarEffectActivatedMessageEvent(onAvatarEffectActivated));
         _com.addHabboConnectionMessageEvent(new BadgeReceivedEvent(onBadgeReceived));
         _com.addHabboConnectionMessageEvent(new TradingYouAreNotAllowedEvent(onTradingYouAreNotAllowed,TradingYouAreNotAllowedParser));
         _com.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomLeft));
         _com.addHabboConnectionMessageEvent(new TradeSilverFeeMessageEvent(onTradeSilverFee));
         _com.addHabboConnectionMessageEvent(new TradeNftAssetsMessageEvent(onTradeNfts));
         _com.addHabboConnectionMessageEvent(new BotRemovedFromInventoryEvent(onBotRemoved));
         _com.addHabboConnectionMessageEvent(new BadgePointLimitsEvent(onBadgePointLimits));
         _com.addHabboConnectionMessageEvent(new TradingOpenEvent(onTradingOpen,TradingOpenParser));
      }
      
      public function dispose() : void
      {
         _inventory = null;
         _com = null;
      }
      
      public function onFurniList(param1:FurniListEvent) : void
      {
         var _loc4_:FurniListParser = param1.getParser();
         if(_loc4_ == null)
         {
            return;
         }
         if(!_inventory.isMainViewInitialized)
         {
            _inventory.initializeFurniturePage();
         }
         var _loc2_:FurniModel = _inventory.furniModel;
         if(_loc2_ == null)
         {
            return;
         }
         if(UnknownVarFromIncomingMessages_Vector_2 == null)
         {
            UnknownVarFromIncomingMessages_Vector_2 = new Vector.<Map>(_loc4_.totalFragments,true);
         }
         var _loc5_:Map = new Map();
         _loc5_.concatenate(_loc4_.furniFragment);
         var _loc3_:Map = addMessageFragment(_loc5_,_loc4_.totalFragments,_loc4_.fragmentNo,UnknownVarFromIncomingMessages_Vector_2);
         if(!_loc3_)
         {
            return;
         }
         _loc2_.insertFurniture(_loc3_);
         UnknownVarFromIncomingMessages_Vector_2 = null;
         _inventory.events.dispatchEvent(new HabboInventoryFurniListParsedEvent("furni"));
      }
      
      public function onFurnitureAddOrUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:FurnitureItem = null;
         var _loc5_:GroupItem = null;
         var _loc3_:UnknownHabboCommunicationMessagesParserInventoryFurni1 = (param1 as FurniListAddOrUpdateEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc7_:FurniModel = _inventory.furniModel;
         if(_loc7_ == null || !_loc7_.isListInited())
         {
            return;
         }
         var _loc8_:Vector.<GroupItem> = new Vector.<GroupItem>();
         var _loc6_:Vector.<FurniData> = _loc3_.getFurni();
         for each(var _loc4_ in _loc6_)
         {
            _loc5_ = _loc7_.getItemWithStripId(_loc4_.itemId);
            if(_loc5_)
            {
               _loc2_ = _loc5_.getItem(_loc4_.itemId);
               if(_loc2_)
               {
                  _loc2_.update(_loc4_);
                  _loc5_.hasUnseenItems = true;
               }
            }
            else
            {
               _loc2_ = new FurnitureItem(_loc4_);
               _loc5_ = _loc7_.addOrUpdateItem(_loc2_,false);
               _loc8_.push(_loc5_);
            }
         }
         if(_loc8_.length > 0)
         {
            _loc7_.updateUnseenItemsThumbs(_loc8_,false);
         }
         _loc7_.setViewToState();
         _loc7_.updateView();
      }
      
      public function onFurniListRemove(param1:IMessageEvent) : void
      {
         var _loc2_:FurniListRemoveParser = (param1 as FurniListRemoveEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc5_:FurniModel = _inventory.furniModel;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.stripId;
         var _loc3_:GroupItem = _loc5_.removeFurni(_loc4_);
         if(_loc3_)
         {
            _loc5_.resetUnseenItems();
         }
      }
      
      public function onFurniListRemoveMultiple(param1:IMessageEvent) : void
      {
         var _loc2_:FurniListRemoveMultipleParser = (param1 as FurniListRemoveMultipleEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:FurniModel = _inventory.furniModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:Boolean = _loc4_.removeFurnis(_loc2_.stripIds);
         if(_loc3_)
         {
            _loc4_.resetUnseenItems();
         }
      }
      
      public function onFurniListInvalidate(param1:IMessageEvent) : void
      {
         _inventory.setInventoryCategoryInit("furni",false);
         _inventory.setInventoryCategoryInit("rentables",false);
      }
      
      public function onPostItPlaced(param1:IMessageEvent) : void
      {
         var _loc2_:PostItPlacedParser = (param1 as PostItPlacedEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:FurniModel = _inventory.furniModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.id;
         var _loc5_:int = _loc2_.itemsLeft;
         _loc3_.updatePostItCount(_loc4_,_loc5_);
      }
      
      public function onAvatarEffects(param1:IMessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:AvatarEffect = null;
         var _loc7_:Effect = null;
         if(_inventory == null)
         {
            return;
         }
         var _loc6_:EffectsModel = _inventory.effectsModel;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc3_:AvatarEffectsMessageParser = (param1 as AvatarEffectsMessageEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:Array = _loc3_.effects;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_] as AvatarEffect;
            _loc7_ = new Effect();
            _loc7_.type = _loc4_.type;
            _loc7_.subType = _loc4_.subType;
            _loc7_.duration = _loc4_.duration;
            _loc7_.isPermanent = _loc4_.isPermanent;
            _loc7_.amountInInventory = _loc4_.inactiveEffectsInInventory;
            if(_loc4_.secondsLeftIfActive >= 0)
            {
               _loc7_.isActive = true;
               _loc7_.secondsLeft = _loc4_.secondsLeftIfActive;
               _loc7_.amountInInventory++;
            }
            else if(_loc4_.secondsLeftIfActive == -1)
            {
               _loc7_.isActive = false;
               _loc7_.secondsLeft = _loc4_.duration;
            }
            _loc6_.addEffect(_loc7_,false);
            _loc5_++;
         }
         _inventory.setInventoryCategoryInit("effects");
         _loc6_.refreshViews();
         _inventory.notifyChangedEffects();
      }
      
      public function onAvatarEffectAdded(param1:IMessageEvent) : void
      {
         var _loc5_:EffectsModel = _inventory.effectsModel;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc2_:AvatarEffectAddedMessageParser = (param1 as AvatarEffectAddedMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc7_:int = _loc2_.type;
         var _loc6_:int = _loc2_.subType;
         var _loc8_:int = _loc2_.duration;
         var _loc3_:Boolean = _loc2_.isPermanent;
         var _loc4_:Effect = new Effect();
         _loc4_.type = _loc7_;
         _loc4_.subType = _loc6_;
         _loc4_.duration = _loc8_;
         _loc4_.isPermanent = _loc3_;
         _loc4_.secondsLeft = _loc8_;
         _loc5_.addEffect(_loc4_);
         _inventory.notifyChangedEffects();
      }
      
      public function onAvatarEffectActivated(param1:IMessageEvent) : void
      {
         var _loc3_:EffectsModel = _inventory.effectsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:AvatarEffectActivatedMessageParser = (param1 as AvatarEffectActivatedMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.type;
         _loc3_.setEffectActivated(_loc4_);
         _inventory.notifyChangedEffects();
      }
      
      public function onAvatarEffectExpired(param1:IMessageEvent) : void
      {
         var _loc3_:EffectsModel = _inventory.effectsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:AvatarEffectExpiredMessageParser = (param1 as AvatarEffectExpiredMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.type;
         _loc3_.setEffectExpired(_loc4_);
         _inventory.notifyChangedEffects();
      }
      
      public function onClubStatus(param1:IMessageEvent) : void
      {
         var _loc2_:ScrSendUserInfoMessageParser = (param1 as ScrSendUserInfoEvent).getParser();
         if(_loc2_.productName == "habbo_club" || _loc2_.productName == "club_habbo")
         {
            _inventory.setClubStatus(_loc2_.periodsSubscribedAhead,_loc2_.daysToPeriodEnd,_loc2_.hasEverBeenMember,_loc2_.isVIP,_loc2_.responseType == 3,_loc2_.responseType == 4,_loc2_.minutesUntilExpiration,_loc2_.minutesSinceLastModified);
            _inventory.events.dispatchEvent(new HabboInventoryHabboClubEvent());
         }
      }
      
      public function onBadges(param1:IMessageEvent) : void
      {
         var _loc3_:BadgesParser = (param1 as BadgesEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:BadgesModel = _inventory.badgesModel;
         if(_loc4_ == null)
         {
            return;
         }
         if(UnknownVarFromIncomingMessages_Vector_4 == null)
         {
            UnknownVarFromIncomingMessages_Int_1 = getTimer();
            UnknownVarFromIncomingMessages_Vector_4 = new Vector.<Map>(_loc3_.totalFragments,true);
         }
         var _loc5_:Map = new Map();
         _loc5_.concatenate(_loc3_.currentFragment);
         var _loc2_:Map = addMessageFragment(_loc5_,_loc3_.totalFragments,_loc3_.fragmentNo,UnknownVarFromIncomingMessages_Vector_4);
         if(!_loc2_)
         {
            return;
         }
         UnknownVarFromIncomingMessages_Vector_4 = null;
         var _loc6_:int = getTimer() - UnknownVarFromIncomingMessages_Int_1;
         UnknownVarFromIncomingMessages_Int_1 = 0;
         Logger.log("Parsing badges took: " + _loc6_ + "ms");
         UnknownVarFromIncomingMessages_Int_1 = getTimer();
         _loc4_.initBadges(_loc2_);
         _loc6_ = getTimer() - UnknownVarFromIncomingMessages_Int_1;
         UnknownVarFromIncomingMessages_Int_1 = 0;
         Logger.log("Initializing badges took: " + _loc6_ + "ms");
         _loc4_.updateView();
         _inventory.setInventoryCategoryInit("badges");
      }
      
      public function onCollectibles(param1:IMessageEvent) : void
      {
         var _loc3_:TradeNftAssetInventoryMessageParser = (param1 as TradeNftAssetInventoryMessageEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:CollectiblesModel = _inventory.collectiblesModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:Map = new Map();
         for each(var _loc2_ in _loc3_.items)
         {
            _loc5_.add(_loc2_.assetId,_loc2_);
         }
         _loc4_.initCollectibles(_loc5_);
      }
      
      public function onTradeNfts(param1:IMessageEvent) : void
      {
         var _loc2_:TradeNftAssetsMessageParser = (param1 as TradeNftAssetsMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:CollectiblesModel = _inventory.collectiblesModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:Map = parseNftTradeMap(_loc2_.myItems,_loc4_);
         var _loc5_:Map = parseNftTradeMap(_loc2_.theirItems,_loc4_);
         var _loc6_:TradingModel = _inventory.tradingModel;
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.updateNftItems(_loc3_,_loc5_,_loc2_.myItems.length,_loc2_.theirItems.length);
      }
      
      public function parseNftTradeMap(param1:Vector.<TradeNftItem>, param2:CollectiblesModel) : Map
      {
         var _loc6_:String = null;
         var _loc7_:CollectibleGroupedItem = null;
         var _loc4_:* = undefined;
         var _loc5_:Map = new Map();
         for each(var _loc3_ in param1)
         {
            _loc6_ = _loc3_.productCode;
            _loc7_ = _loc5_.getValue(_loc6_);
            if(_loc7_ == null)
            {
               _loc4_ = new Vector.<Number>();
               _loc4_.push(_loc3_.assetId);
               _loc7_ = new CollectibleGroupedItem(_loc3_,_loc4_,param2);
               _loc5_.add(_loc6_,_loc7_);
               _loc7_.initializeImage();
            }
            else
            {
               _loc7_.addAssetId(_loc3_.assetId);
            }
         }
         return _loc5_;
      }
      
      public function onBadgePointLimits(param1:IMessageEvent) : void
      {
         var _loc2_:BadgePointLimitsParser = (param1 as BadgePointLimitsEvent).getParser();
         for each(var _loc3_ in _loc2_.data)
         {
            _inventory.localization.setBadgePointLimit(_loc3_.badgeId,_loc3_.limit);
         }
      }
      
      public function onUserBadges(param1:IMessageEvent) : void
      {
         var _loc2_:HabboUserBadgesMessageEvent = param1 as HabboUserBadgesMessageEvent;
         if(_loc2_.userId != _inventory.sessionData.userId)
         {
            return;
         }
         var _loc4_:BadgesModel = _inventory.badgesModel;
         if(_loc4_ == null)
         {
            return;
         }
         UnknownVarFromIncomingMessages_Int_1 = getTimer();
         for each(var _loc3_ in _loc2_.selectedBadges)
         {
            _loc4_.updateBadge(_loc3_.badgeCode,true,0,_loc3_.ownerCount,_loc3_.badgeRarityId);
         }
         var _loc5_:int = getTimer() - UnknownVarFromIncomingMessages_Int_1;
         UnknownVarFromIncomingMessages_Int_1 = 0;
         Logger.log("Updating badges " + _loc2_.selectedBadges.length + "took: " + _loc5_ + "ms");
         UnknownVarFromIncomingMessages_Int_1 = getTimer();
         _loc4_.updateView();
         _loc5_ = getTimer() - UnknownVarFromIncomingMessages_Int_1;
         UnknownVarFromIncomingMessages_Int_1 = 0;
         Logger.log("Updating badge view took: " + _loc5_ + "ms");
      }
      
      public function onAchievementReceived(param1:IMessageEvent) : void
      {
         var _loc4_:HabboAchievementNotificationMessageEvent = param1 as HabboAchievementNotificationMessageEvent;
         var _loc3_:HabboAchievementNotificationMessageParser = _loc4_.getParser();
         var _loc2_:BadgesModel = _inventory.badgesModel;
         if(_loc2_ != null)
         {
            _loc2_.updateBadge(_loc3_.data.badgeCode,false,_loc3_.data.badgeId,_loc3_.data.ownerCount,_loc3_.data.badgeRarityId);
            _loc2_.removeBadge(_loc3_.data.removedBadgeCode);
            _loc2_.updateView();
         }
      }
      
      public function onBadgeReceived(param1:IMessageEvent) : void
      {
         var _loc3_:BadgeReceivedParser = BadgeReceivedEvent(param1).getParser();
         var _loc2_:BadgesModel = _inventory.badgesModel;
         if(_loc2_ != null)
         {
            _loc2_.updateBadge(_loc3_.badgeCode,false,_loc3_.badgeId,_loc3_.ownerCount,_loc3_.badgeRarityId);
            _loc2_.updateView();
         }
      }
      
      public function onAchievementsScore(param1:IMessageEvent) : void
      {
         var _loc2_:AchievementsScoreEvent = param1 as AchievementsScoreEvent;
         var _loc3_:AchievementsScoreMessageParser = _loc2_.getParser() as AchievementsScoreMessageParser;
         if(_loc3_ == null)
         {
            return;
         }
         _inventory.localization.registerParameter("achievements_score_description","score",_loc3_.score.toString());
      }
      
      private function onTradingOpen(param1:IMessageEvent) : void
      {
         var _loc14_:* = 0;
         if(!_inventory)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - inventory is null!");
            return;
         }
         if(_inventory.windowManager.LilithCustomsInstance.OnTradingOpen(param1) == false)
         {
            return;
         }
         var _loc2_:ISessionDataManager = _inventory.sessionData;
         var _loc17_:IRoomSession = _inventory.roomSession;
         if(!_loc2_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - sessionData not available!");
            return;
         }
         if(!_loc17_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - roomSession not available!");
            return;
         }
         _inventory.toggleInventorySubPage("trading");
         var _loc6_:TradingOpenEvent = param1 as TradingOpenEvent;
         if(!_loc6_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","event is of unknown type:" + param1 + "!");
            return;
         }
         var _loc9_:* = _loc6_.userID;
         var _loc3_:IUserData = _loc17_.userDataManager.getUserData(_loc9_);
         if(!_loc3_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - failed to retrieve own user data!");
            return;
         }
         var _loc7_:* = _loc3_.name;
         var _loc5_:* = _loc6_.userCanTrade > 0;
         var _loc15_:* = _loc6_.otherUserID;
         var _loc16_:IUserData = _loc17_.userDataManager.getUserData(_loc15_);
         if(!_loc16_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - failed to retrieve other user data!");
            return;
         }
         var _loc12_:* = _loc16_.name;
         var _loc11_:* = _loc6_.otherUserCanTrade > 0;
         var _loc4_:* = _loc15_ == _loc2_.userId;
         if(_loc15_ == _loc2_.userId)
         {
            _loc14_ = _loc9_;
            var _loc10_:* = _loc7_;
            var _loc8_:* = _loc5_;
            _loc9_ = _loc15_;
            _loc7_ = _loc12_;
            _loc5_ = _loc11_;
            _loc15_ = _loc14_;
            _loc12_ = _loc10_;
            _loc11_ = _loc8_;
         }
         var _loc13_:TradingModel = _inventory.tradingModel;
         if(_loc13_ != null)
         {
            _loc13_.startTrading(_loc9_,_loc7_,_loc5_,_loc15_,_loc12_,_loc11_,_loc4_);
         }
      }
      
      private function onTradingOpenFailed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingClose(param1:IMessageEvent) : void
      {
         if(_inventory.windowManager.LilithCustomsInstance.OnTradingClose(param1) == false)
         {
            return;
         }
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingCompleted(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingAccepted(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradeSilverFee(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradeSilverSet(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingConfirmation(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingItemList(param1:IMessageEvent) : void
      {
         var _loc8_:GroupItem = null;
         var _loc2_:TradingItemListEvent = param1 as TradingItemListEvent;
         var _loc4_:Map = new Map();
         var _loc5_:Map = new Map();
         var _loc6_:int = _inventory.sessionData.userId;
         var _loc3_:FurniModel = _inventory.furniModel;
         if(_loc3_ == null)
         {
            return;
         }
         if(_inventory.getBoolean("trading.warning.enabled") && _loc2_.secondUserNumCredits > 0)
         {
            _loc8_ = _inventory.furniModel.createCreditGroupItem(_loc2_.secondUserNumCredits);
            _loc5_.add("credit_groupitem_type_id",_loc8_);
         }
         populateItemGroups(_loc2_.firstUserItemArray,_loc4_,_loc2_.firstUserID == _loc6_);
         populateItemGroups(_loc2_.secondUserItemArray,_loc5_,_loc2_.secondUserID == _loc6_);
         var _loc7_:TradingModel = _inventory.tradingModel;
         if(_loc7_ != null)
         {
            _loc7_.updateItemGroupMaps(_loc2_,_loc4_,_loc5_);
         }
      }
      
      private function populateItemGroups(param1:Array, param2:Map, param3:Boolean) : void
      {
         var _loc9_:GroupItem = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:String = null;
         var _loc4_:ItemDataStructure = null;
         var _loc6_:int = 0;
         var _loc10_:uint = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc10_)
         {
            _loc4_ = param1[_loc6_] as ItemDataStructure;
            _loc7_ = _loc4_.itemTypeId;
            _loc8_ = _loc4_.category;
            _loc5_ = _loc4_.itemType + String(_loc7_);
            if(!_loc4_.isGroupable || isFurniExternalImage(_loc4_.itemTypeId))
            {
               _loc5_ = "itemid" + _loc4_.itemId;
            }
            if(_loc4_.category == 6)
            {
               _loc5_ = String(_loc7_) + "poster" + _loc4_.stuffData.getLegacyString();
            }
            else if(_loc4_.category == 17)
            {
               _loc5_ = TradingModel.getGuildFurniType(_loc7_,_loc4_.stuffData);
            }
            _loc9_ = _loc4_.isGroupable && !isFurniExternalImage(_loc4_.itemTypeId) ? param2.getValue(_loc5_) as GroupItem : null;
            if(_loc9_ == null)
            {
               _loc9_ = _inventory.furniModel.createGroupItem(_loc7_,_loc8_,_loc4_.stuffData);
               param2.add(_loc5_,_loc9_);
            }
            _loc9_.push(new FurnitureItem(_loc4_));
            _loc6_++;
         }
      }
      
      private function isFurniExternalImage(param1:int) : Boolean
      {
         var _loc2_:IFurnitureData = _inventory.getFurnitureData(param1,"i");
         return _loc2_ && _loc2_.isExternalImageType;
      }
      
      private function onTradingNotOpen(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingOtherNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingYouAreNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onRoomLeft(param1:IMessageEvent) : void
      {
         _inventory.closeView();
         _inventory.furniModel.roomLeft();
      }
      
      private function onFlatAccessDenied(param1:IMessageEvent) : void
      {
         var _loc2_:FlatAccessDeniedMessageParser = (param1 as FlatAccessDeniedMessageEvent).getParser();
         if(_inventory.sessionData == null || _loc2_.userName != _inventory.sessionData.userName)
         {
            return;
         }
         _inventory.closeView();
         _inventory.furniModel.roomLeft();
      }
      
      private function onPets(param1:PetInventoryEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc4_:PetsModel = _inventory.petsModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:PetInventoryMessageParser = param1.getParser();
         if(UnknownVarFromIncomingMessages_Vector_1 == null)
         {
            UnknownVarFromIncomingMessages_Vector_1 = new Vector.<Map>(_loc3_.totalFragments,true);
         }
         var _loc5_:Map = new Map();
         _loc5_.concatenate(_loc3_.petListFragment);
         var _loc2_:Map = addMessageFragment(_loc5_,_loc3_.totalFragments,_loc3_.fragmentNo,UnknownVarFromIncomingMessages_Vector_1);
         if(!_loc2_)
         {
            return;
         }
         _inventory.petsModel.updatePets(_loc2_);
         UnknownVarFromIncomingMessages_Vector_1 = null;
      }
      
      private function onPetAdded(param1:PetAddedToInventoryEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:PetsModel = _inventory.petsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:PetAddedToInventoryParser = param1.getParser();
         _loc3_.addPet(_loc2_.pet);
         if(_loc2_.openInventory())
         {
         }
      }
      
      private function onGoToBreedingNestFailure(param1:GoToBreedingNestFailureEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc2_:String = "${gotobreedingnestfailure.getnest}";
         var _loc3_:Function = getNest;
         if(param1.getParser().reason == 6)
         {
            _loc2_ = "${gotobreedingnestfailure.getfood}";
            _loc3_ = getFood;
         }
         _inventory.windowManager.simpleAlert("${gotobreedingnestfailure.caption}","${gotobreedingnestfailure.subtitle}","${gotobreedingnestfailure.message." + param1.getParser().reason + "}",_loc2_,"",null,null,_loc3_);
      }
      
      private function getNest() : void
      {
         var _loc1_:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.nests");
         _inventory.catalog.openCatalogPage(_loc1_);
      }
      
      private function getFood() : void
      {
         var _loc1_:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.food");
         _inventory.catalog.openCatalogPage(_loc1_);
      }
      
      private function onPetRemoved(param1:PetRemovedFromInventoryEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:PetsModel = _inventory.petsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:PetRemovedFromInventoryParser = param1.getParser();
         _loc3_.removePet(_loc2_.petId);
      }
      
      private function onBots(param1:BotInventoryEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:BotInventoryMessageParser = param1.getParser();
         _loc3_.updateItems(_loc2_.items);
         _inventory.setInventoryCategoryInit("bots");
         _loc3_.setListInitialized();
      }
      
      private function onBotRemoved(param1:BotRemovedFromInventoryEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:BotRemovedFromInventoryParser = param1.getParser();
         _loc3_.removeItem(_loc2_.itemId);
      }
      
      private function onBotAdded(param1:BotAddedToInventoryEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.items.length >= _inventory.botsMax)
         {
            return;
         }
         var _loc2_:BotAddedToInventoryParser = param1.getParser();
         _loc3_.addItem(_loc2_.item);
      }
      
      private function onMarketplaceConfiguration(param1:MarketplaceConfigurationEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc4_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:MarketplaceConfigurationParser = param1.getParser();
         _loc4_.isEnabled = _loc3_.isEnabled;
         _loc4_.commission = _loc3_.commission;
         _loc4_.tokenBatchPrice = _loc3_.tokenBatchPrice;
         _loc4_.tokenBatchSize = _loc3_.tokenBatchSize;
         _loc4_.offerMinPrice = _loc3_.offerMinPrice;
         _loc4_.offerMaxPrice = _loc3_.offerMaxPrice;
         _loc4_.expirationHours = _loc3_.expirationHours;
         _loc4_.averagePricePeriod = _loc3_.averagePricePeriod;
         _loc4_.sellingFeePercentage = _loc3_.sellingFeePercentage;
         _loc4_.revenueLimit = _loc3_.revenueLimit;
         _loc4_.halfTaxLimit = _loc3_.halfTaxLimit;
         _inventory.setInventoryCategoryInit("marketplace");
         var _loc2_:FurniModel = _inventory.furniModel;
         if(_loc2_ != null)
         {
            _loc2_.updateView();
         }
      }
      
      private function onMarketplaceCanMakeOfferResult(param1:MarketplaceCanMakeOfferResult) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:MarketplaceCanMakeOfferResultParser = param1.getParser();
         _loc3_.proceedOfferMaking(_loc2_.resultCode,_loc2_.tokenCount);
      }
      
      private function onMarketplaceMakeOfferResult(param1:MarketplaceMakeOfferResult) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:MarketplaceMakeOfferResultParser = param1.getParser();
         _loc3_.endOfferMaking(_loc2_.result);
      }
      
      private function onMarketplaceItemStats(param1:MarketplaceItemStatsEvent) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc4_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:MarketplaceItemStatsParser = param1.getParser();
         var _loc3_:MarketplaceItemStats = new MarketplaceItemStats();
         _loc3_.averagePrice = _loc2_.averagePrice;
         _loc3_.offerCount = _loc2_.offerCount;
         _loc3_.historyLength = _loc2_.historyLength;
         _loc3_.dayOffsets = _loc2_.dayOffsets;
         _loc3_.averagePrices = _loc2_.averagePrices;
         _loc3_.soldAmounts = _loc2_.soldAmounts;
         _loc3_.furniCategoryId = _loc2_.furniCategoryId;
         _loc3_.furniTypeId = _loc2_.furniTypeId;
         _loc3_.lowestCurrentPrice = _loc2_.lowestCurrentPrice;
         _loc3_.suggestedPrice = _loc2_.suggestedPrice;
         _loc4_.setItemStats(_loc3_);
      }
      
      private function onNotEnoughCredits(param1:NotEnoughBalanceMessageEvent) : void
      {
         if(!param1 || !_inventory)
         {
            return;
         }
         var _loc2_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.onNotEnoughCredits();
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:MarketplaceModel = null;
         if(_inventory.isInventoryCategoryInit("marketplace"))
         {
            _loc2_ = _inventory.marketplaceModel;
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.requestInitialization();
         }
      }
      
      private function onFigureSetIds(param1:FigureSetIdsEvent) : void
      {
         _inventory.updatePurchasedFigureSetIds(param1.getParser().figureSetIds,param1.getParser().boundFurnitureNames);
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         if(_inventory.getBoolean("effects.reactivate.on.room.entry"))
         {
            _inventory.effectsModel.reactivateLastEffect();
         }
         _inventory.furniModel.roomEntered();
      }
      
      private function addMessageFragment(param1:Map, param2:int, param3:int, param4:Vector.<Map>) : Map
      {
         if(param2 == 1)
         {
            return param1;
         }
         param4[param3] = param1;
         for each(var _loc5_ in param4)
         {
            if(_loc5_ == null)
            {
               return null;
            }
         }
         var _loc6_:Map = new Map();
         for each(var _loc7_ in param4)
         {
            _loc6_.concatenate(_loc7_);
            _loc7_.dispose();
         }
         param4 = null;
         return _loc6_;
      }
      
      private function onWiredTradeInitiate(param1:WiredTradeInitiateMessageEvent) : void
      {
         if(!_inventory)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - inventory is null!");
            return;
         }
         var _loc2_:ISessionDataManager = _inventory.sessionData;
         var _loc8_:IRoomSession = _inventory.roomSession;
         if(!_loc2_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - sessionData not available!");
            return;
         }
         if(!_loc8_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - roomSession not available!");
            return;
         }
         var _loc4_:WiredTradeInitiateMessageParser = param1.getParser();
         var _loc3_:TradeRequirement = _loc4_.requirement;
         if(_loc3_ != null && _loc3_.rules != null && _loc3_.rules.youGiveRule == null)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Initiated a trade where the user gives nothing - not possible");
            return;
         }
         var _loc9_:Boolean = _loc4_.showRequirementsImmediate;
         var _loc6_:Boolean = _loc4_.overridePreviousTrade;
         var _loc5_:int = _loc4_.timeoutSeconds;
         var _loc7_:WiredTradingModel = _inventory.wiredTradingModel;
         if(_loc7_ != null)
         {
            _loc7_.onWiredTradeInitiate(_loc3_,_loc9_,_loc6_,_loc5_);
         }
      }
      
      private function onWiredTradeCancelled(param1:WiredTradeCancelledMessageEvent) : void
      {
         _inventory.wiredTradingModel.tradeIsCancelled((param1.getParser() as WiredTradeCancelledMessageParser).transactionFailureTypeId);
      }
      
      private function onWiredTradeCompleted(param1:WiredTradeCompletedMessageEvent) : void
      {
         _inventory.wiredTradingModel.tradeIsCompleted();
      }
      
      private function onWiredTradeItemsUpdate(param1:WiredTradeItemsUpdateMessageEvent) : void
      {
         var _loc8_:GroupItem = null;
         var _loc6_:Map = new Map();
         var _loc5_:Map = new Map();
         var _loc2_:FurniModel = _inventory.furniModel;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:WiredTradeItemsUpdateMessageParser = param1.getParser();
         var _loc3_:TradingItemListParser = _loc4_.tradingItems;
         if(_loc3_.secondUserNumCredits > 0)
         {
            _loc8_ = _inventory.furniModel.createCreditGroupItem(_loc3_.secondUserNumCredits);
            _loc5_.add("credit_groupitem_type_id",_loc8_);
         }
         populateItemGroups(_loc3_.firstUserItemArray,_loc6_,true);
         populateItemGroups(_loc3_.secondUserItemArray,_loc5_,false);
         var _loc7_:WiredTradingModel = _inventory.wiredTradingModel;
         if(_loc7_ != null)
         {
            _loc7_.updateItemGroupMaps(_loc3_,_loc6_,_loc5_,_loc4_.canAccept,_loc4_.extra);
         }
      }
   }
}

