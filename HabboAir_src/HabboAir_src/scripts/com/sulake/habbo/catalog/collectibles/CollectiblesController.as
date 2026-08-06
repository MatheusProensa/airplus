package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.collectibles.renderer.model.BaseItemWrapper;
   import com.sulake.habbo.catalog.collectibles.util.CollectibleRarity;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.collectibles.RedeemNftLootBoxResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.RedeemNftLootBoxStateMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.treasurehunt.ProgressTreasureHuntMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.RedeemNftLootBoxResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.RedeemNftLootBoxStateMessageEventParser;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.events.HabboInventoryCategoryInitializeEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class CollectiblesController extends Component implements ILinkEventTracker, ICollectiblesController
   {
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _inventory:IHabboInventory;
      
      private var _notifications:IHabboNotifications;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var UnknownVarFromCollectiblesController_CollectiblesView_1:CollectiblesView;
      
      private var UnknownVarFromCollectiblesController_CollectiblesRewardBoxView_1:CollectiblesRewardBoxView;
      
      private var UnknownVarFromCollectiblesController_Boolean_1:Boolean = false;
      
      private var UnknownVarFromCollectiblesController_Int_1:int = -1;
      
      private var UnknownVarFromCollectiblesController_String_1:String = "";
      
      private var UnknownVarFromCollectiblesController_Int_2:int = 0;
      
      public function CollectiblesController(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         },false,[{
            "type":"HABBO_INVENTORY_CATEGORY_INITIALIZED",
            "callback":onInventoryInitialize
         }])]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _catalog.events.addEventListener("catalog_purse_emerald_balance",onEmeraldBalance);
         _catalog.events.addEventListener("catalog_purse_silver_balance",onSilverBalance);
         var _loc1_:Vector.<IMessageEvent> = new Vector.<IMessageEvent>(0);
         _loc1_.push(new RedeemNftLootBoxStateMessageEvent(onRedeemLootBoxStateEvent));
         _loc1_.push(new RedeemNftLootBoxResultMessageEvent(onRedeemLootBoxResultEvent));
         for each(var _loc2_ in _loc1_)
         {
            addMessageEvent(_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         if(!UnknownVarFromCollectiblesController_Boolean_1)
         {
            if(_catalog)
            {
               if(_catalog.events)
               {
                  _catalog.events.removeEventListener("catalog_purse_emerald_balance",onEmeraldBalance);
                  _catalog.events.removeEventListener("catalog_purse_silver_balance",onSilverBalance);
               }
               _catalog = null;
            }
            if(UnknownVarFromCollectiblesController_CollectiblesView_1)
            {
               UnknownVarFromCollectiblesController_CollectiblesView_1.dispose();
               UnknownVarFromCollectiblesController_CollectiblesView_1 = null;
            }
            _communicationManager = null;
            _sessionDataManager = null;
            _windowManager = null;
            _localizationManager = null;
            _roomEngine = null;
            UnknownVarFromCollectiblesController_Boolean_1 = true;
         }
         super.dispose();
      }
      
      private function onEmeraldBalance(param1:PurseEvent) : void
      {
         updateView();
      }
      
      public function onSilverBalance(param1:PurseEvent) : void
      {
         updateView();
      }
      
      private function onRedeemLootBoxStateEvent(param1:RedeemNftLootBoxStateMessageEvent) : void
      {
         var _loc6_:String = null;
         var _loc4_:Object = null;
         var _loc3_:RedeemNftLootBoxStateMessageEventParser = param1.getParser();
         var _loc2_:* = _sessionDataManager.userId == _loc3_.openerAvatarId;
         if(_loc3_.start)
         {
            return;
         }
         var _loc5_:BaseItemWrapper = new BaseItemWrapper(_loc3_.reward);
         if(_loc2_)
         {
            showLootBoxReward(_loc5_);
         }
         else
         {
            _loc6_ = localizationManager.getLocalizationWithParams("collectibles.reward_box.notif.desc","","name",localizationManager.getLocalization("generic.someone"),"item",getProductName(_loc5_));
            _loc4_ = {};
            _loc4_["product"] = _loc5_;
            _loc4_["rarity"] = _loc3_.reward.rarity;
            _loc4_["rarity_color"] = CollectibleRarity.getRarityColor(_loc3_.reward.rarity);
            _notifications.addItem(_loc6_,"nft_opening",null,null,_loc4_);
         }
      }
      
      private function onRedeemLootBoxResultEvent(param1:RedeemNftLootBoxResultMessageEvent) : void
      {
         var _loc2_:RedeemNftLootBoxResultMessageEventParser = param1.getParser();
         if(_loc2_.fail)
         {
            notifications.addItem(localizationManager.getLocalization("generic.error"),"info","icon_curator_stamp_large_png");
         }
         if(_loc2_.notInStarDustWallet)
         {
            notifications.addItem(localizationManager.getLocalization("collectibles.reward_box.wrong_wallet"),"info","icon_curator_stamp_large_png");
         }
      }
      
      private function updateView() : void
      {
         if(UnknownVarFromCollectiblesController_CollectiblesView_1)
         {
            UnknownVarFromCollectiblesController_CollectiblesView_1.updateBalances(_catalog.getPurse());
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function getProductType(param1:IProductDisplayInfo) : String
      {
         var _loc2_:String = null;
         if(param1 == null)
         {
            return "unknown";
         }
         switch(param1.productTypeId)
         {
            case 0:
               _loc2_ = localizationManager.getLocalization("product.type.wall");
               break;
            case 1:
               _loc2_ = localizationManager.getLocalization("product.type.room");
               break;
            case 2:
               _loc2_ = localizationManager.getLocalization("product.type.effect");
               break;
            case 4:
               _loc2_ = localizationManager.getLocalization("product.type.badge");
               break;
            case 9:
               _loc2_ = localizationManager.getLocalization("product.type.chatstyle");
               break;
            case 10:
               _loc2_ = localizationManager.getLocalization("product.type.pets");
               break;
            case 11:
               _loc2_ = localizationManager.getLocalization("product.type.clothing");
               break;
            default:
               _loc2_ = "Unknown";
         }
         return _loc2_;
      }
      
      public function getProductName(param1:IProductDisplayInfo) : String
      {
         var _loc2_:IFurnitureData = null;
         _loc2_ = null;
         if(param1 == null)
         {
            return "unknown";
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               return "unknown";
            case 1:
               _loc2_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc2_ == null)
               {
                  return "(missing wall item)";
               }
               return _loc2_.localizedName;
               break;
            case 2:
            case 12:
               _loc2_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc2_ == null)
               {
                  return "(missing floor item)";
               }
               return _loc2_.localizedName;
               break;
            case 3:
               return localizationManager.getLocalization("fx_" + param1.itemTypeId);
            case 5:
               return localizationManager.getBadgeName(param1.itemTypeId);
            case 10:
               return localizationManager.getLocalization("product.type.chatstyle");
            case 11:
               return localizationManager.getLocalization("pet.type." + param1.itemTypeId);
            default:
               Logger.log("[CollectiblesController] Can not yet handle this type of product: ");
               return "(missing)";
         }
      }
      
      public function previewIcon(param1:IProductDisplayInfo, param2:UnknownIHabboCatalogCollectibles1) : void
      {
         var _loc4_:IFurnitureData = null;
         _loc4_ = null;
         var _loc5_:int = 0;
         var _loc3_:UnknownHabboRoom1 = null;
         var _loc6_:int = 0;
         _loc3_ = null;
         if(param1 == null)
         {
            param2.setUnknownImage();
            return;
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               param2.setUnknownImage();
               break;
            case 1:
               _loc4_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               _loc5_ = tempCategoryMapping("I",_loc4_.id);
               if(_loc5_ == 1)
               {
                  param2.imageResult = _roomEngine.getWallItemIcon(_loc4_.id,param2);
                  break;
               }
               param2.clearPreviewer();
               break;
            case 2:
            case 12:
               _loc4_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.imageResult = _roomEngine.getFurnitureIcon(_loc4_.id,param2);
               break;
            case 3:
               _loc3_ = new UnknownHabboRoom1();
               _loc3_.data = _catalog.getPixelEffectIcon(parseInt(param1.itemTypeId));
               param2.imageResult = _loc3_;
               break;
            case 5:
               param2.badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc6_ = parseInt(param1.itemTypeId);
               _loc3_ = new UnknownHabboRoom1();
               _loc3_.data = _freeFlowChat.chatStyleLibrary.getStyle(_loc6_).selectorPreview;
               param2.imageResult = _loc3_;
               break;
            case 11:
               param2.petResult = param1.petFigureString;
               break;
            default:
               Logger.log("[CollectiblesController] Can not yet handle this type of product: ");
               param2.clearPreviewer();
         }
      }
      
      public function previewImage(param1:IProductDisplayInfo, param2:UnknownIHabboCatalogCollectibles1) : void
      {
         var _loc7_:String = null;
         var _loc4_:IFurnitureData = null;
         _loc4_ = null;
         var _loc6_:int = 0;
         var _loc3_:UnknownHabboRoom1 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            param2.setUnknownImage();
            return;
         }
         if(handlePreviewImageEasterEgg(param1,param2))
         {
            return;
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               param2.setUnknownImage();
               break;
            case 1:
               _loc4_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               _loc6_ = tempCategoryMapping("I",_loc4_.id);
               if(_loc6_ == 1)
               {
                  param2.imageResult = _roomEngine.getWallItemImage(_loc4_.id,new Vector3d(90),64,param2);
               }
               else
               {
                  param2.clearPreviewer();
               }
               break;
            case 2:
               _loc4_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.imageResult = _roomEngine.getFurnitureImage(_loc4_.id,new Vector3d(90,0,0),64,param2);
               break;
            case 3:
               if(param1.itemTypeId == "")
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.setEffectResult(_sessionDataManager.figure,parseInt(param1.itemTypeId));
               break;
            case 5:
               param2.badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc3_ = new UnknownHabboRoom1();
               _loc5_ = createChatItemPreview(parseInt(param1.itemTypeId));
               if(_loc5_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               _loc3_.data = _loc5_;
               param2.imageResult = _loc3_;
               break;
            case 11:
               param2.petResult = param1.petFigureString;
               break;
            case 12:
               _loc7_ = _avatarRenderManager.getFigureStringWithFigureIds(_sessionDataManager.figure,_sessionDataManager.gender,param1.figureSetIds);
               param2.avatarResult = _loc7_;
               break;
            default:
               Logger.log("[CollectiblesController] Can not yet handle this type of product: ");
               param2.clearPreviewer();
         }
      }
      
      private function onInventoryInitialize(param1:HabboInventoryCategoryInitializeEvent) : void
      {
         var _loc2_:String = param1.category;
         if(UnknownVarFromCollectiblesController_CollectiblesView_1 != null && UnknownVarFromCollectiblesController_CollectiblesView_1.mintInventoryListWidget != null)
         {
            UnknownVarFromCollectiblesController_CollectiblesView_1.mintInventoryListWidget.onInventoryInitialize(_loc2_);
         }
      }
      
      public function itemAddedToInventory(param1:int, param2:int, param3:Boolean) : void
      {
         if(UnknownVarFromCollectiblesController_CollectiblesView_1 != null && UnknownVarFromCollectiblesController_CollectiblesView_1.mintInventoryListWidget != null)
         {
            UnknownVarFromCollectiblesController_CollectiblesView_1.mintInventoryListWidget.amountChangedForItem("furni",param1,param3);
         }
      }
      
      public function itemRemovedFromInventory(param1:int, param2:int, param3:Boolean) : void
      {
         if(UnknownVarFromCollectiblesController_CollectiblesView_1 != null && UnknownVarFromCollectiblesController_CollectiblesView_1.mintInventoryListWidget != null)
         {
            UnknownVarFromCollectiblesController_CollectiblesView_1.mintInventoryListWidget.amountChangedForItem("furni",param1,param3);
         }
      }
      
      private function handlePreviewImageEasterEgg(param1:IProductDisplayInfo, param2:UnknownIHabboCatalogCollectibles1) : Boolean
      {
         var _loc6_:String = null;
         var _loc3_:UnknownHabboRoom1 = null;
         var _loc4_:BitmapData = null;
         var _loc5_:String = null;
         if(param1.productTypeId == UnknownVarFromCollectiblesController_Int_1 && param1.itemTypeId == UnknownVarFromCollectiblesController_String_1)
         {
            UnknownVarFromCollectiblesController_Int_2 += 1;
         }
         else
         {
            UnknownVarFromCollectiblesController_Int_2 = 1;
         }
         UnknownVarFromCollectiblesController_Int_1 = param1.productTypeId;
         UnknownVarFromCollectiblesController_String_1 = param1.itemTypeId;
         if(param1.productTypeId == 9)
         {
            _loc6_ = "";
            if(UnknownVarFromCollectiblesController_Int_2 == 7)
            {
               _loc6_ = "Evil Frank";
            }
            if(UnknownVarFromCollectiblesController_Int_2 == 10)
            {
               _loc6_ = "Bonne Blonde";
            }
            if(UnknownVarFromCollectiblesController_Int_2 == 15)
            {
               _loc6_ = "Furni fairy";
            }
            if(UnknownVarFromCollectiblesController_Int_2 == 22)
            {
               _loc6_ = "Wacky Wired";
            }
            if(UnknownVarFromCollectiblesController_Int_2 == 35)
            {
               _loc6_ = "Quacky duck";
            }
            if(UnknownVarFromCollectiblesController_Int_2 == 70)
            {
               _loc6_ = "Pixel poo";
            }
            if(UnknownVarFromCollectiblesController_Int_2 == 100)
            {
               _loc6_ = "Bobba filtered";
            }
            if(_loc6_ != "")
            {
               _loc3_ = new UnknownHabboRoom1();
               _loc4_ = createChatItemPreview(parseInt(param1.itemTypeId),_loc6_);
               if(_loc4_ == null)
               {
                  return false;
               }
               _loc3_.data = _loc4_;
               param2.imageResult = _loc3_;
               _loc5_ = _loc6_.substr(0,3);
               if(_loc6_.indexOf("red") == 8 && param1.itemTypeId == "1020")
               {
                  send(new ProgressTreasureHuntMessageComposer("wf15",_loc5_ + _loc5_ + _loc5_ + _loc5_ + _loc5_));
               }
               return true;
            }
         }
         return false;
      }
      
      private function createChatItemPreview(param1:int, param2:String = null) : BitmapData
      {
         if(param2 == null)
         {
            param2 = _sessionDataManager.userName;
         }
         var _loc6_:ChatStyle = _freeFlowChat.chatStyleLibrary.getStyle(param1) as ChatStyle;
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc3_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",0);
         var _loc4_:ChatItem = new ChatItem(_loc3_,getTimer(),null,0,null,null,null,param2);
         var _loc5_:PooledChatBubble = new PooledChatBubble(_freeFlowChat as HabboFreeFlowChat);
         _loc5_.chatItem = _loc4_;
         _loc5_.face = null;
         _loc5_.style = _loc6_;
         _loc5_.recreate(param2,0,false);
         var _loc7_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc7_.draw(_loc5_);
         return _loc7_;
      }
      
      private function tempCategoryMapping(param1:String, param2:int) : int
      {
         if(param1 == "S")
         {
            return 1;
         }
         if(param1 == "I")
         {
            if(param2 == 3001)
            {
               return 2;
            }
            if(param2 == 3002)
            {
               return 3;
            }
            if(param2 == 4057)
            {
               return 4;
            }
            return 1;
         }
         return 1;
      }
      
      public function get linkPattern() : String
      {
         return "collectibles/";
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showCollectibleHub();
         }
      }
      
      private function showCollectibleHub() : void
      {
         if(!UnknownVarFromCollectiblesController_CollectiblesView_1 || UnknownVarFromCollectiblesController_CollectiblesView_1.disposed)
         {
            UnknownVarFromCollectiblesController_CollectiblesView_1 = new CollectiblesView(this,_windowManager);
            updateView();
         }
         else
         {
            UnknownVarFromCollectiblesController_CollectiblesView_1.showWindow();
         }
      }
      
      private function showLootBoxReward(param1:BaseItemWrapper) : void
      {
         if(!UnknownVarFromCollectiblesController_CollectiblesRewardBoxView_1 || UnknownVarFromCollectiblesController_CollectiblesRewardBoxView_1.disposed)
         {
            UnknownVarFromCollectiblesController_CollectiblesRewardBoxView_1 = new CollectiblesRewardBoxView(this,_windowManager);
            UnknownVarFromCollectiblesController_CollectiblesRewardBoxView_1.showReward(param1,true);
         }
         else
         {
            UnknownVarFromCollectiblesController_CollectiblesRewardBoxView_1.showReward(param1,false);
         }
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get inventory() : IHabboInventory
      {
         return _inventory;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
   }
}

