package com.sulake.habbo.catalog
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IHabboAvatarEditorManager;
   import com.sulake.habbo.catalog.club.ClubBuyController;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.club.ClubExtendController;
   import com.sulake.habbo.catalog.club.ClubGiftController;
   import com.sulake.habbo.catalog.clubcenter.HabboClubCenter;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.ICollectiblesController;
   import com.sulake.habbo.catalog.collectibles.tabs.MintTokenPurchaseOffer;
   import com.sulake.habbo.catalog.collectibles.tabs.NftStorePurchaseOffer;
   import com.sulake.habbo.catalog.earnings.EarningsController;
   import com.sulake.habbo.catalog.earnings.IEarningsController;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.event.CatalogUserEvent;
   import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
   import com.sulake.habbo.catalog.habbicons.HabbiconController;
   import com.sulake.habbo.catalog.marketplace.IMarketPlace;
   import com.sulake.habbo.catalog.marketplace.MarketPlaceLogic;
   import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
   import com.sulake.habbo.catalog.navigation.CatalogNavigator;
   import com.sulake.habbo.catalog.navigation.ICatalogNavigator;
   import com.sulake.habbo.catalog.navigation.ICatalogNode;
   import com.sulake.habbo.catalog.navigation.events.CatalogFurniPurchaseEvent;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.catalog.offers.OfferCenter;
   import com.sulake.habbo.catalog.purchase.GiftWrappingConfiguration;
   import com.sulake.habbo.catalog.purchase.PlacedObjectPurchaseData;
   import com.sulake.habbo.catalog.purchase.PurchaseConfirmationDialog;
   import com.sulake.habbo.catalog.purchase.RentConfirmationWindow;
   import com.sulake.habbo.catalog.purchase.RoomAdPurchaseData;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.catalog.purse.Purse;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.catalog.recycler.RecyclerLogic;
   import com.sulake.habbo.catalog.search.CatalogSearchEntry;
   import com.sulake.habbo.catalog.special_items_display.SpecialItemsController;
   import com.sulake.habbo.catalog.targetedoffers.OfferController;
   import com.sulake.habbo.catalog.viewer.CatalogViewer;
   import com.sulake.habbo.catalog.viewer.FurnitureOffer;
   import com.sulake.habbo.catalog.viewer.GameTokensOffer;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IPageLocalization;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.PageLocalization;
   import com.sulake.habbo.catalog.viewer.Product;
   import com.sulake.habbo.catalog.viewer.UnknownIHabboCatalogViewer1;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBuilderSubscriptionUpdatedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetRoomChangedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetPalettesEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubFurniCountMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubSubscriptionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRuleset;
   import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRulesetMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.FrontPageItem;
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftReceiverNotFoundEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.LimitedEditionSoldOutEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.LtdRaffleEnteredMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.LtdRaffleResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.ProductOfferEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.SellablePetPalettesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.SnowWarGameTokensMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemErrorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemOkMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.EmeraldBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftStorePurchaseMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.SilverBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.purse.CreditBalanceEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelAllOffersResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceClearOwnHistoryResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
   import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ApproveNameMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceRoomItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceWallItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubQueryFurniCountMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetBundleDiscountRulesetComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogIndexComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubOffersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetGiftWrappingConfigurationComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetIsOfferGiftableComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetProductOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetRoomAdPurchaseInfoComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetSellablePetPalettesComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.MarkCatalogNewAdditionsPageOpenedComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseBasicMembershipExtensionComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogAsGiftComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseRoomAdMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseSnowWarGameTokensOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseVipMembershipExtensionComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.RedeemVoucherMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.RoomAdPurchaseInitiatedComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftStorePurchaseMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.PurchaseMintTokenMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.CancelAllMarketplaceOffersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.CancelMarketplaceOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.ClearMarketplaceOwnHistoryMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceOffersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceOwnOffersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.RedeemMarketplaceOfferCreditsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.recycler.GetRecyclerPrizesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.recycler.GetRecyclerStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.recycler.RecycleItemsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.ApproveNameMessageComposer;
   import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubSubscriptionStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.BundleDiscountRulesetMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftInfoParser;
   import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.LtdRaffleResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.catalog.NotEnoughBalanceMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.ProductOfferMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseNotAllowedMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseOKMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.SellablePetPalettesParser;
   import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokenOffer;
   import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokensMessageParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.EmeraldBalanceMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftStorePurchaseMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.SilverBalanceMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons1;
   import com.sulake.habbo.communication.messages.parser.inventory.purse.CreditBalanceParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerFinishedMessageEvent;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerFinishedMessageParser;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerPrizesMessageEvent;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerPrizesMessageParser;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerStatusMessageEvent;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.ApproveNameMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.friendbar.events.FriendBarSelectionEvent;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.quest.IHabboQuestEngine;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedOnUserEvent;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.furniture.UnknownIHabboSessionFurniture1;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.session.product.UnknownIHabboSessionProduct1;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductImageWidget;
   import com.sulake.iid.*;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class HabboCatalog extends Component implements IHabboCatalog, UnknownIHabboSessionProduct1, IProfiler_1, ILinkEventTracker, UnknownIHabboSessionFurniture1
   {
      public static const GET_SNOWWAR_TOKENS:String = "GET_SNOWWAR_TOKENS";
      
      public static const GET_SNOWWAR_TOKENS2:String = "GET_SNOWWAR_TOKENS2";
      
      public static const GET_SNOWWAR_TOKENS3:String = "GET_SNOWWAR_TOKENS3";
      
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const MAX_SEARCH_RESULTS_LENGTH:uint = 400;
      
      private static const NO_KNOWN_OFFER:int = -1;
      
      private static const DEFAULT_VIEW_LOCATION:Point = new Point(100,20);
      
      private static const DEFAULT_VIEW_LOCATION_LARGE:Point = new Point(100,5);
      
      private static const SEARCH_PRODUCT_CODE_OVERRIDES_BY_FURNI_CLASS_NAME:Object = {};
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _roomSession:IRoomSession;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _notifications:IHabboNotifications;
      
      private var _inventory:IHabboInventory;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _friendList:IHabboFriendList;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _avatarEditor:IHabboAvatarEditorManager;
      
      private var _questEngine:IHabboQuestEngine;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _videoOffers:VideoOfferManager;
      
      private var UnknownVarFromHabboCatalog_Boolean_1:Boolean = false;
      
      private var UnknownVarFromHabboCatalog_Boolean_2:Boolean = false;
      
      private var UnknownVarFromHabboCatalog_Boolean_3:Boolean = false;
      
      private var UnknownVarFromHabboCatalog_CatalogViewer_1:CatalogViewer;
      
      private var _catalogNavigators:Dictionary;
      
      private var _catalogStates:Dictionary;
      
      private var _purse:Purse;
      
      private var _recycler:RecyclerLogic;
      
      private var _marketPlace:IMarketPlace;
      
      private var _mainContainer:IWindowController_1;
      
      private var UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1:PurchaseConfirmationDialog;
      
      private var UnknownVarFromHabboCatalog_String_1:String;
      
      private var UnknownVarFromHabboCatalog_Boolean_4:Boolean;
      
      private var UnknownVarFromHabboCatalog_Boolean_5:Boolean = true;
      
      private var _privateRoomSessionActive:Boolean = false;
      
      private var _giftWrappingConfiguration:GiftWrappingConfiguration;
      
      private var _clubGiftController:ClubGiftController;
      
      private var _clubBuyController:ClubBuyController;
      
      private var _clubExtendController:ClubExtendController;
      
      private var _sellablePetPalettes:Map = new Map();
      
      private var UnknownVarFromHabboCatalog_Boolean_6:Boolean = false;
      
      private var _offerInFurniPlacing:UnknownIHabboCatalog1;
      
      private var _offerPlacingCallbackReceiver:UnknownIHabboCatalogViewer1;
      
      private var UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1:PlacedObjectPurchaseData;
      
      private var UnknownVarFromHabboCatalog_Boolean_7:Boolean;
      
      private var UnknownVarFromHabboCatalog_Boolean_8:Boolean;
      
      private var UnknownVarFromHabboCatalog_RoomPreviewer_1:RoomPreviewer;
      
      private var _groupMembershipsController:GuildMembershipsController;
      
      private var UnknownVarFromHabboCatalog_OfferController_1:OfferController;
      
      private var _utils:HabboCatalogUtils;
      
      private var UnknownVarFromHabboCatalog_Boolean_9:Boolean = false;
      
      private var UnknownVarFromHabboCatalog_String_2:String = null;
      
      private var UnknownVarFromHabboCatalog_GameTokensOffer_1:GameTokensOffer;
      
      private var UnknownVarFromHabboCatalog_GameTokensOffer_2:GameTokensOffer;
      
      private var UnknownVarFromHabboCatalog_GameTokensOffer_3:GameTokensOffer;
      
      private var _bundleDiscountRuleset:BundleDiscountRuleset = null;
      
      private var _roomAdPurchaseData:RoomAdPurchaseData;
      
      private var UnknownVarFromHabboCatalog_RentConfirmationWindow_1:RentConfirmationWindow;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _catalogType:String = "NORMAL";
      
      private var UnknownVarFromHabboCatalog_Point_1:Point;
      
      private var UnknownVarFromHabboCatalog_Boolean_10:Boolean;
      
      private var UnknownVarFromHabboCatalog_String_3:String;
      
      private var UnknownVarFromHabboCatalog_Boolean_11:Boolean;
      
      private var UnknownVarFromHabboCatalog_Boolean_12:Boolean = true;
      
      private var UnknownVarFromHabboCatalog_Vector_1:Vector.<IFurnitureData>;
      
      private var _frontPageItems:Vector.<FrontPageItem>;
      
      private var UnknownVarFromHabboCatalog_Timer_1:Timer;
      
      private var _searchEntries:Vector.<CatalogSearchEntry>;
      
      private var UnknownVarFromHabboCatalog_Boolean_13:Boolean = true;
      
      private var _pagesVisibleInBuilderMode:Dictionary;
      
      private var UnknownVarFromHabboCatalog_Boolean_14:Boolean;
      
      private var _builderFurniCount:int = -1;
      
      private var _builderFurniLimit:int;
      
      private var _builderMaxFurniLimit:int;
      
      private var UnknownVarFromHabboCatalog_Int_1:int;
      
      private var UnknownVarFromHabboCatalog_Int_2:int;
      
      private var _builderMembershipUpdateTime:int;
      
      private var _builderMembershipDisplayUpdateTime:int;
      
      private var UnknownVarFromHabboCatalog_Boolean_15:Boolean;
      
      private var UnknownVarFromHabboCatalog_Boolean_16:Boolean;
      
      private var _offerCenter:OfferCenter;
      
      private var _collectorHub:CollectiblesController;
      
      private var _habbiconController:HabbiconController;
      
      private var _specialItemsController:SpecialItemsController;
      
      private var _earnings:EarningsController;
      
      public function HabboCatalog(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _purse = new Purse();
         _utils = new HabboCatalogUtils(this);
         registerUpdateReceiver(this,1);
         UnknownVarFromHabboCatalog_Point_1 = DEFAULT_VIEW_LOCATION_LARGE.clone();
         param1.attachComponent(new HabboClubCenter(param1,0,param3),[new IIDHabboClubCenter()]);
         _earnings = new EarningsController(param1,0,param3);
         param1.attachComponent(_earnings,[new IIDVaultController()]);
         _collectorHub = new CollectiblesController(param1,0,param3);
         param1.attachComponent(_collectorHub,[new IIDCollectiblesController()]);
         _habbiconController = new HabbiconController(param1,0,param3);
         param1.attachComponent(_habbiconController,[new IIDHabbiconController()]);
         _specialItemsController = new SpecialItemsController(param1,0,param3);
         param1.attachComponent(_specialItemsController,[new IIDSpecialItemsController()]);
      }
      
      private static function matchesSearchEntry(param1:CatalogSearchEntry, param2:String) : Boolean
      {
         for each(var _loc3_ in param1.searchTerms)
         {
            if(_loc3_.indexOf(param2) >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function addSearchTerm(param1:Vector.<String>, param2:String) : void
      {
         var _loc3_:String = normalizeSearchText(param2);
         if(_loc3_.length > 0 && param1.indexOf(_loc3_) < 0)
         {
            param1.push(_loc3_);
         }
      }
      
      private static function isExcludedFromFurnitureSearchResults(param1:IFurnitureData) : Boolean
      {
         return startsWith(param1.className,"bc_");
      }
      
      private static function startsWith(param1:String, param2:String) : Boolean
      {
         return param1 != null && param1.indexOf(param2) == 0;
      }
      
      private static function normalizeSearchText(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.toLocaleLowerCase();
      }
      
      private static function resolveSearchProductCode(param1:IFurnitureData) : String
      {
         var _loc2_:String = SEARCH_PRODUCT_CODE_OVERRIDES_BY_FURNI_CLASS_NAME[param1.className];
         return _loc2_ ?? param1.className;
      }
      
      public static function setElementImageCentered(param1:IWindowModel, param2:BitmapData, param3:int = 0) : void
      {
         var _loc7_:IBitmapWrapperController = null;
         var _loc4_:IDisplayObjectWrapperController = null;
         if(param2 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.disposed)
         {
            return;
         }
         var _loc8_:int = param3 > 0 ? param3 : param1.height;
         var _loc5_:int = (param1.width - param2.width) / 2;
         var _loc6_:int = (_loc8_ - param2.height) / 2;
         if(param1 as IBitmapWrapperController != null)
         {
            _loc7_ = IBitmapWrapperController(param1);
            if(_loc7_.bitmap == null || param3 > 0)
            {
               _loc7_.bitmap = new BitmapData(param1.width,_loc8_,true,16777215);
            }
            _loc7_.bitmap.fillRect(_loc7_.bitmap.rect,16777215);
            _loc7_.bitmap.copyPixels(param2,param2.rect,new Point(_loc5_,_loc6_),null,null,false);
            param1.invalidate();
         }
         else if(param1 as IDisplayObjectWrapperController != null)
         {
            _loc4_ = IDisplayObjectWrapperController(param1);
            _loc4_.setDisplayObject(new Bitmap(param2));
            param1.invalidate();
         }
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get connection() : IConnection
      {
         return _communication.connection;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get giftWrappingConfiguration() : GiftWrappingConfiguration
      {
         return _giftWrappingConfiguration;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get soundManager() : IHabboSoundManagerFlash10
      {
         return _soundManager;
      }
      
      public function get roomPreviewer() : RoomPreviewer
      {
         if(UnknownVarFromHabboCatalog_RoomPreviewer_1 == null)
         {
            initializeRoomPreviewer();
         }
         return UnknownVarFromHabboCatalog_RoomPreviewer_1;
      }
      
      public function get navigator() : IHabboNavigator_1
      {
         return _newNavigator.legacyNavigator;
      }
      
      public function get utils() : HabboCatalogUtils
      {
         return _utils;
      }
      
      public function get questEngine() : IHabboQuestEngine
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : IHabboFreeFlowChat
      {
         return _freeFlowChat;
      }
      
      public function get videoOffers() : IVideoOfferManager
      {
         return _videoOffers;
      }
      
      public function get frontPageItems() : Vector.<FrontPageItem>
      {
         return _frontPageItems;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         },false),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REOE_PLACED",
            "callback":onObjectPlacedInRoom
         },{
            "type":"REOE_PLACED_ON_USER",
            "callback":onObjectPlaceOnUser
         },{
            "type":"REOE_SELECTED",
            "callback":onObjectSelected
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         },false),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         },false),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         }]),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         },false),new ComponentDependency(new IIDHabboFriendBar(),null,false,[{
            "type":"FBVE_FRIEND_SELECTED",
            "callback":onFriendBarSelectionEvent
         }]),new ComponentDependency(new IIDHabboGroupsManager(),null,false,[{
            "type":"GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",
            "callback":onGuildVisualSettingsChanged
         }]),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:IHabboAvatarEditorManager):void
         {
            _avatarEditor = param1;
         },false),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:IHabboQuestEngine):void
         {
            _questEngine = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new RecyclerPrizesMessageEvent(onRecyclerPrizes));
         addMessageEvent(new BuildersClubSubscriptionStatusMessageEvent(onBuildersClubSubscriptionStatus));
         addMessageEvent(new GuildMembershipsMessageEvent(onGuildMemberships));
         addMessageEvent(new MarketPlaceOffersEvent(onMarketPlaceOffers));
         addMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointNotification));
         addMessageEvent(new SellablePetPalettesMessageEvent(onSellablePalettes));
         addMessageEvent(new ActivityPointsMessageEvent(onActivityPoints));
         addMessageEvent(new ProductOfferEvent(onProductOffer));
         addMessageEvent(new NftStorePurchaseMessageEvent(onNftStorePurchase));
         addMessageEvent(new VoucherRedeemOkMessageEvent(onVoucherRedeemOk));
         addMessageEvent(new CatalogPublishedMessageEvent(onCatalogPublished));
         addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         addMessageEvent(new LimitedEditionSoldOutEvent(onLimitedEditionSoldOut));
         addMessageEvent(new MarketplaceClearOwnHistoryResultEvent(onMarketPlaceClearOwnHistoryResult));
         addMessageEvent(new SnowWarGameTokensMessageEvent(onSnowWarGameTokenOffer));
         addMessageEvent(new LtdRaffleEnteredMessageEvent(onLtdRaffleEntered));
         addMessageEvent(new GiftReceiverNotFoundEvent(onGiftReceiverNotFound));
         addMessageEvent(new ClubGiftInfoEvent(onClubGiftInfo));
         addMessageEvent(new BuildersClubFurniCountMessageEvent(onBuildersClubFurniCount));
         addMessageEvent(new LtdRaffleResultMessageEvent(onLtdRaffleResult));
         addMessageEvent(new PurchaseNotAllowedMessageEvent(onPurchaseNotAllowed));
         addMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
         addMessageEvent(new RecyclerFinishedMessageEvent(onRecyclerFinished));
         addMessageEvent(new MarketplaceMakeOfferResult(onMarketplaceMakeOfferResult));
         addMessageEvent(new CreditBalanceEvent(onCreditBalance));
         addMessageEvent(new CatalogIndexMessageEvent(onCatalogIndex));
         addMessageEvent(new PurchaseErrorMessageEvent(onPurchaseError));
         addMessageEvent(new MarketplaceItemStatsEvent(onMarketplaceItemStats));
         addMessageEvent(new NotEnoughBalanceMessageEvent(onNotEnoughBalance));
         addMessageEvent(new BundleDiscountRulesetMessageEvent(onBundleDiscountRulesetMessageEvent));
         addMessageEvent(new MarketplaceCancelAllOffersResultEvent(onMarketPlaceCancelAllResult));
         addMessageEvent(new PurchaseOKMessageEvent(onPurchaseOK));
         addMessageEvent(new MarketPlaceOwnOffersEvent(onMarketPlaceOwnOffers));
         addMessageEvent(new RecyclerStatusMessageEvent(onRecyclerStatus));
         addMessageEvent(new HabboClubOffersMessageEvent(onHabboClubOffers));
         addMessageEvent(new SilverBalanceMessageEvent(onSilverBalance));
         addMessageEvent(new MarketplaceBuyOfferResultEvent(onMarketPlaceBuyResult));
         addMessageEvent(new GiftWrappingConfigurationEvent(onGiftWrappingConfiguration));
         addMessageEvent(new HabboClubExtendOfferMessageEvent(onHabboClubExtendOffer));
         addMessageEvent(new CatalogPageMessageEvent(onCatalogPage));
         addMessageEvent(new EmeraldBalanceMessageEvent(onEmeraldBalance));
         addMessageEvent(new ApproveNameMessageEvent(onApproveNameResult));
         addMessageEvent(new MarketplaceConfigurationEvent(onMarketplaceConfiguration));
         addMessageEvent(new VoucherRedeemErrorMessageEvent(onVoucherRedeemError));
         addMessageEvent(new MarketplaceCancelOfferResultEvent(onMarketPlaceCancelResult));
         context.addLinkEventTracker(this);
         _sessionDataManager.loadProductData(this);
         UnknownVarFromHabboCatalog_Boolean_8 = isNewItemsNotificationEnabled();
         _videoOffers = new VideoOfferManager(this);
         UnknownVarFromHabboCatalog_OfferController_1 = new OfferController(this);
         UnknownVarFromHabboCatalog_Vector_1 = _sessionDataManager.getFurniData(this);
         _pagesVisibleInBuilderMode = null;
      }
      
      private function onLtdRaffleResult(param1:LtdRaffleResultMessageEvent) : void
      {
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.ltdRaffleEnded();
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.dispose();
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 = null;
         }
         var _loc2_:LtdRaffleResultMessageEventParser = param1.getParser() as LtdRaffleResultMessageEventParser;
         var _loc4_:String = "notification.raffle." + (_loc2_.hasWon ? "won" : "lost");
         var _loc3_:String = _localization.getLocalization(_loc4_,_loc4_);
         _notifications.addItem(_loc3_,"ltd");
      }
      
      private function onLtdRaffleEntered(param1:LtdRaffleEnteredMessageEvent) : void
      {
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.ltdRaffleStarted();
         }
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         removeUpdateReceiver(this);
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(_videoOffers)
         {
            _videoOffers.dispose();
            _videoOffers = null;
         }
         if(_offerCenter != null)
         {
            _offerCenter.dispose();
            _offerCenter = null;
         }
         reset(true);
         context.removeLinkEventTracker(this);
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.dispose();
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 = null;
         }
         if(_recycler != null)
         {
            _recycler.dispose();
            _recycler = null;
         }
         _purse = null;
         _marketPlace = null;
         if(_clubBuyController != null)
         {
            _clubBuyController.dispose();
            _clubBuyController = null;
         }
         if(_clubExtendController != null)
         {
            _clubExtendController.dispose();
            _clubExtendController = null;
         }
         if(_sellablePetPalettes != null)
         {
            _sellablePetPalettes.dispose();
            _sellablePetPalettes = null;
         }
         _roomSession = null;
         if(UnknownVarFromHabboCatalog_RentConfirmationWindow_1 != null)
         {
            UnknownVarFromHabboCatalog_RentConfirmationWindow_1.dispose();
            UnknownVarFromHabboCatalog_RentConfirmationWindow_1 = null;
         }
         resetPlacedOfferData();
         UnknownVarFromHabboCatalog_Boolean_6 = false;
         _offerPlacingCallbackReceiver = null;
         if(UnknownVarFromHabboCatalog_RoomPreviewer_1 != null)
         {
            UnknownVarFromHabboCatalog_RoomPreviewer_1.dispose();
            UnknownVarFromHabboCatalog_RoomPreviewer_1 = null;
         }
         if(_groupMembershipsController != null)
         {
            _groupMembershipsController.dispose();
            _groupMembershipsController = null;
         }
         if(_utils != null)
         {
            _utils.dispose();
            _utils = null;
         }
         disposeSnowWarTokens();
         if(UnknownVarFromHabboCatalog_OfferController_1)
         {
            UnknownVarFromHabboCatalog_OfferController_1.dispose();
            UnknownVarFromHabboCatalog_OfferController_1 = null;
         }
         super.dispose();
      }
      
      private function disposeSnowWarTokens() : void
      {
         if(UnknownVarFromHabboCatalog_GameTokensOffer_1 != null)
         {
            UnknownVarFromHabboCatalog_GameTokensOffer_1.dispose();
            UnknownVarFromHabboCatalog_GameTokensOffer_1 = null;
         }
         if(UnknownVarFromHabboCatalog_GameTokensOffer_2 != null)
         {
            UnknownVarFromHabboCatalog_GameTokensOffer_2.dispose();
            UnknownVarFromHabboCatalog_GameTokensOffer_2 = null;
         }
         if(UnknownVarFromHabboCatalog_GameTokensOffer_3 != null)
         {
            UnknownVarFromHabboCatalog_GameTokensOffer_3.dispose();
            UnknownVarFromHabboCatalog_GameTokensOffer_3 = null;
         }
      }
      
      private function init(param1:String = null) : Boolean
      {
         if(!UnknownVarFromHabboCatalog_Boolean_1 && UnknownVarFromHabboCatalog_Boolean_2)
         {
            if(UnknownVarFromHabboCatalog_Boolean_3)
            {
               refreshFurniData();
            }
            createCatalogWindowStates();
            setActiveCatalogState(param1 == null ? "NORMAL" : param1);
            UnknownVarFromHabboCatalog_Boolean_1 = true;
            updatePurse();
            createRecycler();
            createMarketPlace();
            createClubGiftController();
            getGiftWrappingConfiguration();
            createClubBuyController();
            createClubExtendController();
            createGroupMembershipsController();
            initBundleDiscounts();
            events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
            send(new BuildersClubQueryFurniCountMessageComposer());
            return true;
         }
         return false;
      }
      
      private function reset(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = false;
         UnknownVarFromHabboCatalog_Boolean_1 = false;
         UnknownVarFromHabboCatalog_CatalogViewer_1 = null;
         _mainContainer = null;
         if(_catalogStates != null)
         {
            for each(var _loc3_ in _catalogStates)
            {
               _loc3_.dispose();
            }
            _catalogStates = null;
         }
         _catalogNavigators = null;
         if(!param1)
         {
            if(_sessionDataManager == null)
            {
               Core.crash("Could not reload product data after reset() because _sessionDataManager was null",7);
               return;
            }
            _loc2_ = _sessionDataManager.loadProductData(this);
            if(!_loc2_)
            {
               events.dispatchEvent(new CatalogEvent("CATALOG_NOT_READY"));
            }
         }
      }
      
      private function send(param1:IMessageComposer) : void
      {
         if(connection == null)
         {
            return;
         }
         connection.send(param1);
      }
      
      public function loadCatalogPage(param1:int, param2:int, param3:String) : void
      {
         setCatalogBusy(param3,true);
         getCatalogState(param3).lastPageRequestId = param1;
         send(new GetCatalogPageComposer(param1,param2,param3));
      }
      
      public function purchaseGameTokensOffer(param1:String) : void
      {
         if(param1 == "GET_SNOWWAR_TOKENS" && UnknownVarFromHabboCatalog_GameTokensOffer_1)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(UnknownVarFromHabboCatalog_GameTokensOffer_1.offerId));
         }
         else if(param1 == "GET_SNOWWAR_TOKENS2" && UnknownVarFromHabboCatalog_GameTokensOffer_2)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(UnknownVarFromHabboCatalog_GameTokensOffer_2.offerId));
         }
         else if(param1 == "GET_SNOWWAR_TOKENS3" && UnknownVarFromHabboCatalog_GameTokensOffer_3)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(UnknownVarFromHabboCatalog_GameTokensOffer_3.offerId));
         }
      }
      
      public function purchaseMintTokens(param1:int, param2:String) : void
      {
         send(new PurchaseMintTokenMessageComposer(param1,param2));
      }
      
      public function purchaseNftOffer(param1:String, param2:String) : void
      {
         send(new NftStorePurchaseMessageComposer(param1,param2));
      }
      
      public function isHabbiconOfferOwned(param1:UnknownIHabboCatalog1) : Boolean
      {
         if(!getBoolean("habbicons.enabled") || param1 == null || param1.product == null || param1.product.productType != "habbicon" || _habbiconController == null)
         {
            return false;
         }
         return isHabbiconOwned(int(param1.product.extraParam));
      }
      
      public function isHabbiconOwned(param1:int) : Boolean
      {
         if(!getBoolean("habbicons.enabled") || _habbiconController == null)
         {
            return false;
         }
         var _loc2_:UnknownHabboCommunicationMessagesParserHabbicons1 = _habbiconController.tryGetOwnedHabbicon(param1);
         return _loc2_ != null;
      }
      
      public function showHabbiconAlreadyOwnedAlert() : void
      {
         _windowManager.alert("${catalog.alert.purchaseerror.title}","${habbicon.catalog.already_owned}",0,alertDialogEventProcessor);
      }
      
      public function purchaseOffer(param1:int, param2:String = "", param3:int = 1) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:ICatalogNavigator = getCatalogNavigator("NORMAL");
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.getNodesByOfferId(param1,true);
            if(_loc4_ != null)
            {
               purchaseProduct(_loc4_[0].pageId,param1,param2,param3);
            }
         }
      }
      
      public function purchaseProduct(param1:int, param2:int, param3:String = "", param4:int = 1) : void
      {
         if(roomAdPurchaseData == null || roomAdPurchaseData.offerId != param2)
         {
            send(new PurchaseFromCatalogComposer(param1,param2,param3,param4));
         }
         else
         {
            if(_roomAdPurchaseData.extended && _roomAdPurchaseData.expirationTime.getTime() < new Date().getTime())
            {
               _roomAdPurchaseData.extended = false;
            }
            send(new PurchaseRoomAdMessageComposer(param1,param2,roomAdPurchaseData.flatId,roomAdPurchaseData.name,roomAdPurchaseData.extended,roomAdPurchaseData.description,roomAdPurchaseData.categoryId));
         }
      }
      
      public function purchaseVipMembershipExtension(param1:int) : void
      {
         send(new PurchaseVipMembershipExtensionComposer(param1));
      }
      
      public function purchaseBasicMembershipExtension(param1:int) : void
      {
         send(new PurchaseBasicMembershipExtensionComposer(param1));
      }
      
      public function purchaseProductAsGift(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int, param7:int, param8:int, param9:Boolean = false) : void
      {
         send(new PurchaseFromCatalogAsGiftComposer(param1,param2,param3,param4,param5,param6,param7,param8,param9));
      }
      
      public function get roomAdPurchaseData() : RoomAdPurchaseData
      {
         return _roomAdPurchaseData;
      }
      
      public function set roomAdPurchaseData(param1:RoomAdPurchaseData) : void
      {
         _roomAdPurchaseData = param1;
      }
      
      public function approveName(param1:String, param2:int) : void
      {
         send(new ApproveNameMessageComposer(param1,param2));
      }
      
      public function getRecyclerStatus() : void
      {
         send(new GetRecyclerStatusMessageComposer());
      }
      
      public function getRecyclerPrizes() : void
      {
         send(new GetRecyclerPrizesMessageComposer());
      }
      
      public function sendRecycleItems(param1:Array) : void
      {
         send(new RecycleItemsMessageComposer(param1));
      }
      
      public function set giftReceiver(param1:String) : void
      {
         UnknownVarFromHabboCatalog_String_1 = param1;
      }
      
      public function getSeasonalCurrencyActivityPointType() : int
      {
         return getInteger("seasonalcurrencyindicator.currency",1);
      }
      
      public function showPurchaseConfirmation(param1:UnknownIHabboCatalog1, param2:int, param3:String = "", param4:int = 1, param5:IStuffData = null, param6:String = null, param7:Boolean = true, param8:BitmapData = null) : void
      {
         var _loc14_:* = undefined;
         var _loc11_:Array = null;
         var _loc9_:* = null;
         var _loc13_:ICatalogNode = null;
         if(param2 == -12345678)
         {
            _loc14_ = currentCatalogNavigator.getNodesByOfferId(param1.offerId,true);
            if(_loc14_ != null)
            {
               param2 = _loc14_[0].pageId;
            }
         }
         Logger.log("buy: " + [param4,param1.offerId,param3]);
         if(isHabbiconOfferOwned(param1))
         {
            showHabbiconAlreadyOwnedAlert();
            return;
         }
         var _loc12_:int = param1.priceInCredits;
         var _loc15_:int = param1.priceInActivityPoints;
         if(multiplePurchaseEnabled)
         {
            _loc12_ = _utils.calculateBundlePrice(true,param1.priceInCredits,param4);
            _loc15_ = _utils.calculateBundlePrice(true,param1.priceInActivityPoints,param4);
         }
         var _loc10_:* = param1 is GameTokensOffer;
         if(_loc12_ > 0 && _loc12_ > _purse.credits && !_loc10_)
         {
            showNotEnoughCreditsAlert();
            return;
         }
         if(_loc15_ > 0 && _loc15_ > _purse.getActivityPointsForType(param1.activityPointType) && !_loc10_)
         {
            showNotEnoughActivityPointsAlert(param1.activityPointType);
            return;
         }
         if(param1 is Offer || UnknownVarFromHabboCatalog_Boolean_4 || param1 is GameTokensOffer || param1 is MintTokenPurchaseOffer || param1 is NftStorePurchaseOffer)
         {
            if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 == null || UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.disposed)
            {
               UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 = new PurchaseConfirmationDialog(_localization,assets);
            }
            _loc11_ = [];
            if(_friendList != null)
            {
               _loc11_ = _friendList.getFriendNames();
            }
            _loc9_ = param6;
            if(_loc9_ == null)
            {
               if(UnknownVarFromHabboCatalog_String_1 != null)
               {
                  _loc9_ = UnknownVarFromHabboCatalog_String_1;
               }
            }
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.showOffer(this,_roomEngine,param1,param2,param3,param4,param5,_loc11_,_loc9_,param8);
         }
         else if(param1 is ClubBuyOfferData)
         {
            if(param2 == -1)
            {
               _loc13_ = currentCatalogNavigator.getNodeByName("hc_membership");
               if(_loc13_ != null)
               {
                  param2 = _loc13_.pageId;
               }
            }
            if(param2 >= 0)
            {
               _clubBuyController.showConfirmation(param1 as ClubBuyOfferData,param2);
            }
         }
         if(UnknownVarFromHabboCatalog_Boolean_4)
         {
            UnknownVarFromHabboCatalog_Boolean_4 = false;
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.turnIntoGifting();
         }
      }
      
      public function purchaseWillBeGift(param1:Boolean) : void
      {
         UnknownVarFromHabboCatalog_Boolean_4 = param1;
      }
      
      private function initializeRoomPreviewer() : void
      {
         if(_roomEngine != null && _roomEngine.isInitialized && getBoolean("catalog.furniture.animation"))
         {
            if(UnknownVarFromHabboCatalog_RoomPreviewer_1 == null)
            {
               UnknownVarFromHabboCatalog_RoomPreviewer_1 = new RoomPreviewer(_roomEngine);
               UnknownVarFromHabboCatalog_RoomPreviewer_1.centerWallItems = true;
               UnknownVarFromHabboCatalog_RoomPreviewer_1.createRoomForPreviews();
            }
         }
      }
      
      private function isNewItemsNotificationEnabled() : Boolean
      {
         return getBoolean("toolbar.new_additions.notification.enabled");
      }
      
      public function openCatalog() : void
      {
         cancelFurniInMover();
         toggleCatalog("NORMAL",true);
      }
      
      public function openCatalogPage(param1:String, param2:String = null) : void
      {
         cancelFurniInMover();
         var _loc3_:String = param2 == null ? "NORMAL" : param2;
         toggleCatalog(_loc3_,true,false);
         var _loc4_:CatalogWindowState = getCatalogState(_loc3_);
         if(!UnknownVarFromHabboCatalog_Boolean_1 || _loc4_ == null || _loc4_.catalogNavigator == null || !_loc4_.catalogNavigator.initialized)
         {
            _loc4_.UnknownVarFromCatalogWindowState_RequestedPage_1.requestByName = param1;
            return;
         }
         _loc4_.catalogNavigator.openPage(param1);
      }
      
      public function openRoomAdCatalogPageInExtendedMode(param1:String, param2:String, param3:String, param4:String, param5:Date, param6:int) : void
      {
         var _loc9_:CatalogWindowState = getCatalogState("NORMAL");
         var _loc8_:int = int(_loc9_ == null ? -1 : _loc9_.lastPageRequestId);
         _roomAdPurchaseData = new RoomAdPurchaseData();
         _roomAdPurchaseData.name = param2;
         _roomAdPurchaseData.extended = true;
         _roomAdPurchaseData.extendedFlatId = _roomEngine.activeRoomId;
         _roomAdPurchaseData.description = param3;
         _roomAdPurchaseData.flatId = _roomEngine.activeRoomId;
         _roomAdPurchaseData.roomName = param4;
         _roomAdPurchaseData.expirationTime = param5;
         _roomAdPurchaseData.categoryId = param6;
         openCatalogPage(param1);
         var _loc7_:ICatalogNode = currentCatalogNavigator.getNodeByName(param1);
         if(_loc7_ != null && _loc7_.pageId == _loc8_)
         {
            getRoomAdsPurchaseInfo();
         }
      }
      
      public function openCatalogPageByOfferId(param1:int, param2:String) : void
      {
         openCatalogPageById(-12345678,param1,param2);
      }
      
      public function openCatalogPageById(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:CatalogWindowState = getCatalogState(param3);
         if(UnknownVarFromHabboCatalog_Boolean_1 && _loc4_ != null && _loc4_.catalogNavigator != null && _loc4_.catalogNavigator.initialized)
         {
            toggleCatalog(param3,true,false);
            _loc4_.catalogViewer.setForceRefresh();
            _loc4_.catalogNavigator.openPageById(param1,param2);
         }
         else
         {
            toggleCatalog(param3);
            _loc4_ = getCatalogState(param3);
            _loc4_.UnknownVarFromCatalogWindowState_RequestedPage_1.requestById = param1;
            _loc4_.UnknownVarFromCatalogWindowState_RequestedPage_1.requestedOfferId = param2;
         }
      }
      
      public function openInventoryCategory(param1:String) : void
      {
         if(_inventory == null)
         {
            return;
         }
         _inventory.toggleInventoryPage(param1);
      }
      
      public function openCreditsHabblet() : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
      }
      
      public function setupInventoryForRecycler(param1:Boolean) : void
      {
         if(_inventory == null)
         {
            return;
         }
         _inventory.setupRecycler(param1);
      }
      
      public function get privateRoomSessionActive() : Boolean
      {
         return _privateRoomSessionActive;
      }
      
      public function get tradingActive() : Boolean
      {
         if(_inventory == null)
         {
            return false;
         }
         return _inventory.tradingActive;
      }
      
      public function requestInventoryFurniToRecycler() : int
      {
         if(_inventory == null)
         {
            return 0;
         }
         return _inventory.requestSelectedFurniToRecycler();
      }
      
      public function returnInventoryFurniFromRecycler(param1:int) : Boolean
      {
         if(_inventory == null)
         {
            return false;
         }
         return _inventory.returnInventoryFurniFromRecycler(param1);
      }
      
      public function getProductData(param1:String) : IProductData
      {
         return _sessionDataManager.getProductData(param1);
      }
      
      public function getFurnitureData(param1:int, param2:String) : IFurnitureData
      {
         var _loc3_:IFurnitureData = null;
         if(param2 == "s")
         {
            _loc3_ = _sessionDataManager.getFloorItemData(param1);
         }
         if(param2 == "i")
         {
            _loc3_ = _sessionDataManager.getWallItemData(param1);
         }
         return _loc3_;
      }
      
      public function getFurnitureDataByName(param1:String, param2:String, param3:int = 0) : IFurnitureData
      {
         var _loc4_:IFurnitureData = null;
         if(_sessionDataManager == null)
         {
            return null;
         }
         if(param2 == "s")
         {
            _loc4_ = _sessionDataManager.getFloorItemDataByName(param1);
         }
         if(param2 == "i")
         {
            _loc4_ = _sessionDataManager.getWallItemDataByName(param1);
         }
         return _loc4_;
      }
      
      public function getPurse() : IPurse
      {
         return _purse;
      }
      
      public function getEarnings() : IEarningsController
      {
         return _earnings;
      }
      
      public function getRecycler() : IRecycler
      {
         return _recycler;
      }
      
      public function getMarketPlace() : IMarketPlace
      {
         return _marketPlace;
      }
      
      public function getClubGiftController() : ClubGiftController
      {
         return _clubGiftController;
      }
      
      public function getClubBuyController() : ClubBuyController
      {
         return _clubBuyController;
      }
      
      public function getClubExtendController() : ClubExtendController
      {
         return _clubExtendController;
      }
      
      public function getPublicMarketPlaceOffers(param1:int, param2:int, param3:String, param4:int, param5:Boolean = true) : void
      {
         send(new GetMarketplaceOffersMessageComposer(param1,param2,param3,param4,param5));
      }
      
      public function getRoomAdsPurchaseInfo() : void
      {
         send(new GetRoomAdPurchaseInfoComposer());
      }
      
      public function sendRoomAdPurchaseInitiatedEvent() : void
      {
         send(new RoomAdPurchaseInitiatedComposer());
      }
      
      public function getOwnMarketPlaceOffers(param1:int = 1) : void
      {
         send(new GetMarketplaceOwnOffersMessageComposer(param1));
      }
      
      public function cancelAllMarketPlaceOffers() : void
      {
         send(new CancelAllMarketplaceOffersMessageComposer());
      }
      
      public function clearOwnMarketPlaceHistory(param1:int) : void
      {
         send(new ClearMarketplaceOwnHistoryMessageComposer(param1));
      }
      
      public function buyMarketPlaceOffer(param1:int) : void
      {
         send(new BuyMarketplaceOfferMessageComposer(param1));
      }
      
      public function redeemSoldMarketPlaceOffers() : void
      {
         send(new RedeemMarketplaceOfferCreditsMessageComposer());
      }
      
      public function redeemExpiredMarketPlaceOffer(param1:int) : void
      {
         send(new CancelMarketplaceOfferMessageComposer(param1));
      }
      
      public function getMarketplaceItemStats(param1:int, param2:int, param3:String = null) : void
      {
         if(!_communication)
         {
            return;
         }
         send(new GetMarketplaceItemStatsComposer(param1,param2,param3));
      }
      
      public function getGroupMembershipsController() : GuildMembershipsController
      {
         return _groupMembershipsController;
      }
      
      public function getPixelEffectIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapDataAsset = (_inventory as Component).assets.getAssetByName("fx_icon_" + param1 + "_png") as BitmapDataAsset;
         if(_loc2_ != null && _loc2_.content != null)
         {
            return (_loc2_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getSubscriptionProductIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapDataAsset = assets.getAssetByName("icon_hc") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            return (_loc2_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getMintTokenProductIcon() : BitmapData
      {
         var _loc1_:BitmapDataAsset = assets.getAssetByName("minting_token_large") as BitmapDataAsset;
         if(_loc1_ != null)
         {
            return (_loc1_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getSellablePetPalettes(param1:String) : Array
      {
         var _loc2_:Array = _sellablePetPalettes.getValue(param1);
         if(_loc2_ != null)
         {
            return _loc2_.slice();
         }
         send(new GetSellablePetPalettesComposer(param1));
         return null;
      }
      
      private function updatePurse() : void
      {
         var _loc5_:String = null;
         var _loc3_:IIconWindow = null;
         var _loc1_:ITextWindow = null;
         _localization.registerParameter("catalog.purse.creditbalance","balance",String(_purse.credits));
         _localization.registerParameter("catalog.purse.pixelbalance","balance",String(_purse.getActivityPointsForType(0)));
         var _loc4_:uint = 11;
         if(!_purse.hasClubLeft)
         {
            _loc5_ = "catalog.purse.club.join";
         }
         else
         {
            if(_purse.isVIP)
            {
               _loc5_ = "catalog.purse.vipdays";
               _loc4_ = 12;
            }
            else
            {
               _loc5_ = "catalog.purse.clubdays";
            }
            _localization.registerParameter(_loc5_,"days",String(_purse.clubDays));
            _localization.registerParameter(_loc5_,"months",String(_purse.clubPeriods));
         }
         if(_catalogStates == null)
         {
            return;
         }
         for each(var _loc2_ in _catalogStates)
         {
            if(_loc2_.mainContainer != null)
            {
               _loc3_ = _loc2_.mainContainer.findChildByName("clubIcon") as IIconWindow;
               if(_loc3_ != null)
               {
                  _loc3_.style = _loc4_;
               }
               _loc1_ = _loc2_.mainContainer.findChildByName("clubText") as ITextWindow;
               if(_loc1_ != null)
               {
                  _loc1_.caption = _localization.getLocalization(_loc5_);
               }
            }
         }
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type != "HTE_TOOLBAR_CLICK")
         {
            return;
         }
         switch(param1.iconId)
         {
            case "HTIE_ICON_CATALOGUE":
               toggleCatalog("NORMAL");
               break;
            case "HTIE_ICON_BUILDER":
               toggleCatalog("BUILDERS_CLUB");
         }
      }
      
      private function setElementColour(param1:String, param2:int) : void
      {
         if(_mainContainer == null)
         {
            return;
         }
         var _loc3_:IWindowModel = _mainContainer.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.color = param2;
         }
      }
      
      private function focusSearchInput(param1:IWindowController_1) : void
      {
         var _loc2_:ITextFieldWindow = param1.findChildByName("search.input") as ITextFieldWindow;
         if(_loc2_ != null)
         {
            _loc2_.focus();
            _loc2_.setSelection(0,_loc2_.text.length);
         }
      }
      
      private function setCatalogBusy(param1:String, param2:Boolean) : void
      {
         var _loc3_:CatalogWindowState = getCatalogState(param1);
         if(_loc3_ == null || _loc3_.mainContainer == null)
         {
            return;
         }
         _loc3_.mainContainer.caption = param2 ? "${generic.loading}" : (param1 == "NORMAL" ? "${catalog.title}" : "${builder.catalog.title}");
         var _loc4_:IWindowModel = _loc3_.mainContainer.findChildByName("search_waiting_for_results_mask");
         if(_loc4_ != null)
         {
            _loc4_.visible = param2;
         }
      }
      
      private function refreshCatalogWindowChrome(param1:String, param2:IWindowController_1) : void
      {
         if(param2 == null)
         {
            return;
         }
         param2.caption = param1 == "NORMAL" ? "${catalog.title}" : "${builder.catalog.title}";
         var _loc3_:IWindowModel = param2.findChildByName("catalog.header.background.border");
         if(_loc3_ != null)
         {
         }
         var _loc5_:IWindowModel = param2.findChildByName("catalog.header.background.body");
         if(_loc5_ != null)
         {
         }
         var _loc4_:IWindowModel = param2.findChildByName("catalog.mode.header");
         if(_loc4_ != null)
         {
            _loc4_.visible = param1 == "NORMAL";
         }
         var _loc6_:IWindowModel = param2.findChildByName("builder.mode.header");
         if(_loc6_ != null)
         {
            _loc6_.visible = param1 == "BUILDERS_CLUB";
         }
      }
      
      public function get buildersClubEnabled() : Boolean
      {
         return getBoolean("builders.club.enabled");
      }
      
      public function toggleCatalog(param1:String, param2:Boolean = false, param3:Boolean = true) : void
      {
         if(!_sessionDataManager.hasSecurity(5) && !buildersClubEnabled)
         {
            param1 = "NORMAL";
         }
         if(UnknownVarFromHabboCatalog_Timer_1 != null)
         {
            UnknownVarFromHabboCatalog_Timer_1.stop();
         }
         cancelFurniInMover();
         if(_catalogStates == null)
         {
            if(init(param1) == false)
            {
               UnknownVarFromHabboCatalog_String_3 = param1;
               UnknownVarFromHabboCatalog_Boolean_11 = param2;
               UnknownVarFromHabboCatalog_Boolean_12 = param3;
               return;
            }
         }
         UnknownVarFromHabboCatalog_String_3 = null;
         var _loc7_:CatalogWindowState = getCatalogState(_catalogType);
         var _loc6_:CatalogWindowState = setActiveCatalogState(param1);
         var _loc5_:Boolean = mainWindowVisible();
         var _loc4_:Boolean = _loc7_ != null && _loc7_ != _loc6_;
         if(_loc6_.catalogNavigator == null || !_loc6_.catalogNavigator.initialized)
         {
            refreshCatalogIndex(param1);
         }
         if(_loc4_ && _loc7_ != null && isMainWindowVisible(_loc7_))
         {
            hideMainWindow(_loc7_,false);
         }
         if(!_loc4_ && _loc5_ && !param2)
         {
            hideMainWindow(_loc6_,true);
         }
         else if(!_loc5_ || param2 || _loc4_)
         {
            if(UnknownVarFromHabboCatalog_Boolean_7)
            {
               UnknownVarFromHabboCatalog_Boolean_7 = false;
               events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_HIDE"));
               markNewAdditionPageOpened();
            }
            showMainWindow(_loc6_);
            if(param3 && _loc6_.catalogViewer.currentPage == null && _loc6_.catalogNavigator.initialized)
            {
               _loc6_.catalogNavigator.showIndex();
               _loc6_.catalogNavigator.loadFrontPage();
            }
            else if(_loc6_.catalogViewer.currentPage != null)
            {
               dispatchRoomChangedToCatalogPage(_loc6_);
            }
         }
         if(mainWindowVisible())
         {
            if(_mainContainer == null)
            {
               Logger.log("[Catalog] No main container!");
            }
            else
            {
               _mainContainer.activate();
               focusSearchInput(_mainContainer);
            }
            HabboTracking.getInstance().trackGoogle("catalogue","open");
         }
         refreshCatalogWindowChrome(param1,_loc6_.mainContainer);
         refreshBuilderStatus();
         if(mainWindowVisible())
         {
            events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_OPEN"));
            if(_recycler != null && getCurrentLayoutCode() == "recycler")
            {
               _recycler.activate();
            }
         }
         else
         {
            events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_CLOSE"));
            if(_recycler != null && _loc7_ != null && _loc7_.catalogViewer != null && _loc7_.catalogViewer.getCurrentLayoutCode() == "recycler")
            {
               _recycler.cancel();
            }
         }
         if(_recycler != null)
         {
            setupInventoryForRecycler(_recycler.active && mainWindowVisible());
         }
      }
      
      private function getCurrentLayoutCode() : String
      {
         if(UnknownVarFromHabboCatalog_CatalogViewer_1 == null)
         {
            return "";
         }
         return UnknownVarFromHabboCatalog_CatalogViewer_1.getCurrentLayoutCode();
      }
      
      private function refreshCatalogIndex(param1:String) : void
      {
         send(new GetCatalogIndexComposer(param1));
      }
      
      private function markNewAdditionPageOpened() : void
      {
         send(new MarkCatalogNewAdditionsPageOpenedComposer());
      }
      
      private function createCatalogWindowStates() : void
      {
         _catalogStates = new Dictionary();
         _catalogNavigators = new Dictionary();
         createCatalogWindowState("NORMAL");
         createCatalogWindowState("BUILDERS_CLUB");
      }
      
      private function createCatalogWindowState(param1:String) : CatalogWindowState
      {
         if(_catalogStates != null && _catalogStates[param1] != null)
         {
            return _catalogStates[param1];
         }
         var _loc3_:CatalogWindowState = new CatalogWindowState(param1);
         _loc3_.mainContainer = createMainWindow(param1);
         if(param1 == "BUILDERS_CLUB")
         {
            _loc3_.mainContainer.height += 15;
         }
         _loc3_.catalogNavigator = new CatalogNavigator(this,_loc3_.mainContainer,param1);
         _loc3_.catalogViewer = new CatalogViewer(this,_loc3_.mainContainer.findChildByName("layoutContainer") as IWindowController_1,param1);
         _catalogStates[param1] = _loc3_;
         _catalogNavigators[param1] = _loc3_.catalogNavigator;
         var _loc2_:BitmapDataAsset = assets.getAssetByName("purse_coins_small") as BitmapDataAsset;
         setElementImageForContainer(_loc3_.mainContainer,"creditsIcon",_loc2_.content as BitmapData);
         var _loc5_:BitmapDataAsset = assets.getAssetByName("purse_pixels_small") as BitmapDataAsset;
         setElementImageForContainer(_loc3_.mainContainer,"pixelsIcon",_loc5_.content as BitmapData);
         var _loc4_:BitmapDataAsset = assets.getAssetByName("purse_club_small") as BitmapDataAsset;
         setElementImageForContainer(_loc3_.mainContainer,"clubIcon",_loc4_.content as BitmapData);
         return _loc3_;
      }
      
      private function createMainWindow(param1:String) : IWindowController_1
      {
         var _loc5_:IWindowModel = null;
         var _loc7_:XmlAsset = assets.getAssetByName(getCatalogWindowAssetName(param1)) as XmlAsset;
         var _loc2_:IWindowController_1 = _windowManager.buildFromXML(_loc7_.content as XML,1) as IWindowController_1;
         _loc2_.tags.push("habbo_catalog");
         _loc2_.position = UnknownVarFromHabboCatalog_Point_1.clone();
         _loc2_.visible = false;
         _loc2_.addEventListener("WE_RELOCATE",onMainWindowRelocate);
         var _loc3_:IWindowController_1 = _loc2_.parent as IWindowController_1;
         if(_loc3_ != null)
         {
            _loc3_.removeChild(_loc2_);
         }
         var _loc6_:IWindowModel = _loc2_.findChildByName("titlebar_close_button");
         if(_loc6_ == null)
         {
            _loc6_ = _loc2_.findChildByTag("close");
         }
         if(_loc6_ != null)
         {
            _loc6_.procedure = onWindowClose;
         }
         var _loc4_:ITextFieldWindow = _loc2_.findChildByName("search.input") as ITextFieldWindow;
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WKE_KEY_DOWN",onSearchInputEvent);
            _loc4_.addEventListener("WKE_KEY_UP",onSearchInputEvent);
            _loc4_.setSelection(0,_loc4_.text.length);
            _loc5_ = _loc2_.findChildByName("clear_search_button");
            if(_loc5_ != null)
            {
               _loc5_.addEventListener("WME_CLICK",onClearSearch);
            }
         }
         refreshCatalogWindowChrome(param1,_loc2_);
         return _loc2_;
      }
      
      private function getCatalogWindowAssetName(param1:String) : String
      {
         return useNonTabbedCatalog(param1) ? "catalog_ubuntu" : "catalog_ubuntu_with_tabs";
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         setCatalogBusy(_catalogType,param1);
      }
      
      private function onSelectSearch(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc2_)
         {
            _loc2_.setSelection(0,_loc2_.text.length);
            _loc2_.focus();
         }
      }
      
      private function onClearSearch(param1:WindowMouseEvent = null) : void
      {
         var _loc2_:ITextFieldWindow = _mainContainer.findChildByName("search.input") as ITextFieldWindow;
         _loc2_.caption = "";
         _loc2_.setSelection(0,_loc2_.text.length);
         _loc2_.focus();
         var _loc3_:IStaticBitmapWrapperWindow = _mainContainer.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc3_.assetUri = "common_small_pen";
         if(UnknownVarFromHabboCatalog_CatalogViewer_1.previousPageId > 0)
         {
            currentCatalogNavigator.openPageById(UnknownVarFromHabboCatalog_CatalogViewer_1.previousPageId,-1);
         }
         _mainContainer.findChildByName("search.helper").visible = true;
      }
      
      private function onSearchInputEvent(param1:WindowKeyboardEvent) : void
      {
         if(param1.type == "WKE_KEY_DOWN")
         {
            if(UnknownVarFromHabboCatalog_Timer_1)
            {
               UnknownVarFromHabboCatalog_Timer_1.stop();
            }
            return;
         }
         if(UnknownVarFromHabboCatalog_Timer_1 == null)
         {
            UnknownVarFromHabboCatalog_Timer_1 = new Timer(50,1);
            UnknownVarFromHabboCatalog_Timer_1.addEventListener("timer",onKeyUpSearchTimer);
         }
         if(param1.target.caption.length >= 3)
         {
            UnknownVarFromHabboCatalog_Timer_1.reset();
            UnknownVarFromHabboCatalog_Timer_1.start();
         }
         var _loc2_:IWindowModel = _mainContainer.findChildByName("search.helper");
         _loc2_.visible = param1.target.caption.length == 0;
         var _loc3_:IStaticBitmapWrapperWindow = _mainContainer.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc3_.assetUri = param1.target.caption.length > 0 ? "icons_close" : "common_small_pen";
         if(param1.target.caption.length == 0)
         {
            onClearSearch();
         }
         else if(param1.keyCode == 13)
         {
            performSearch(param1.target.caption);
         }
      }
      
      private function onKeyUpSearchTimer(param1:TimerEvent) : void
      {
         var _loc2_:ITextFieldWindow = _mainContainer.findChildByName("search.input") as ITextFieldWindow;
         performSearch(_loc2_.caption);
      }
      
      private function performSearch(param1:String) : void
      {
         var _loc8_:IFurnitureData = null;
         var _loc3_:UnknownIHabboCatalog1 = null;
         var _loc6_:String = null;
         if(UnknownVarFromHabboCatalog_Timer_1)
         {
            UnknownVarFromHabboCatalog_Timer_1.stop();
         }
         if(UnknownVarFromHabboCatalog_Vector_1 == null || param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc9_:CatalogWindowState = getCatalogState(_catalogType);
         if(_loc9_ == null || _loc9_.catalogNavigator == null || _loc9_.catalogViewer == null || _loc9_.mainContainer == null)
         {
            return;
         }
         ensureSearchEntries();
         var _loc4_:Array = [];
         var _loc5_:Vector.<UnknownIHabboCatalog1> = new Vector.<UnknownIHabboCatalog1>(0);
         var _loc7_:Dictionary = new Dictionary();
         var _loc10_:String = normalizeSearchText(param1);
         for each(var _loc2_ in _searchEntries)
         {
            _loc8_ = _loc2_.furniData;
            if(!(_catalogType == "BUILDERS_CLUB" && !_loc8_.availableForBuildersClub))
            {
               if(!(_catalogType == "NORMAL" && _loc8_.excludedFromDynamic))
               {
                  if(matchesSearchEntry(_loc2_,_loc10_))
                  {
                     _loc3_ = createSearchResultOffer(_loc2_);
                     if(_loc3_ != null)
                     {
                        addMatchingNodesForOffer(_loc3_.offerId,_loc7_);
                        if(!isExcludedFromFurnitureSearchResults(_loc8_))
                        {
                           _loc5_.push(_loc3_);
                           if(_loc5_.length >= 400)
                           {
                              break;
                           }
                        }
                     }
                     else if(_catalogType == "BUILDERS_CLUB" && _loc8_.furniLine != "")
                     {
                        _loc6_ = normalizeSearchText(_loc8_.furniLine);
                        if(_loc6_.length > 0 && _loc4_.indexOf(_loc6_) < 0)
                        {
                           _loc4_.push(_loc6_);
                        }
                     }
                  }
               }
            }
         }
         localization.registerParameter("catalog.search.results","count",_loc5_.length.toString());
         localization.registerParameter("catalog.search.results","needle",param1);
         var _loc11_:IWindowModel = _loc9_.mainContainer.findChildByName("catalog.header.title");
         if(_loc11_ != null)
         {
            _loc11_.caption = "${catalog.search.header}";
         }
         _loc9_.catalogNavigator.deactivateCurrentNode();
         _loc9_.catalogViewer.showSearchResults(_loc5_);
         _loc9_.catalogNavigator.filter(_loc10_,_loc4_,_loc7_);
      }
      
      private function ensureSearchEntries() : void
      {
         var _loc1_:String = null;
         var _loc5_:String = null;
         var _loc4_:IProductData = null;
         var _loc2_:* = undefined;
         if(!UnknownVarFromHabboCatalog_Boolean_13)
         {
            return;
         }
         _searchEntries = new Vector.<CatalogSearchEntry>(0);
         if(UnknownVarFromHabboCatalog_Vector_1 != null)
         {
            for each(var _loc3_ in UnknownVarFromHabboCatalog_Vector_1)
            {
               _loc1_ = resolveSearchProductCode(_loc3_);
               _loc5_ = "";
               if(UnknownVarFromHabboCatalog_Boolean_2 && _loc1_ != null && _loc1_.length > 0)
               {
                  _loc4_ = getProductData(_loc1_);
                  if(_loc4_ != null && _loc4_.name != null)
                  {
                     _loc5_ = _loc4_.name;
                  }
               }
               _loc2_ = new Vector.<String>(0);
               addSearchTerm(_loc2_,_loc3_.localizedName);
               addSearchTerm(_loc2_,_loc5_);
               _searchEntries.push(new CatalogSearchEntry(_loc3_,_loc2_,_loc1_));
            }
         }
         UnknownVarFromHabboCatalog_Boolean_13 = false;
      }
      
      private function createSearchResultOffer(param1:CatalogSearchEntry) : UnknownIHabboCatalog1
      {
         var _loc3_:IFurnitureData = param1.furniData;
         var _loc2_:int = -1;
         var _loc4_:Boolean = false;
         if(_catalogType == "BUILDERS_CLUB")
         {
            if(_loc3_.bcOfferId != -1 && currentCatalogNavigator.getNodesByOfferId(_loc3_.bcOfferId,true) != null)
            {
               _loc2_ = _loc3_.bcOfferId;
            }
         }
         else if(_loc3_.purchaseOfferId != -1 && currentCatalogNavigator.getNodesByOfferId(_loc3_.purchaseOfferId,true) != null)
         {
            _loc2_ = _loc3_.purchaseOfferId;
         }
         else if(_loc3_.rentOfferId != -1 && currentCatalogNavigator.getNodesByOfferId(_loc3_.rentOfferId,true) != null)
         {
            _loc2_ = _loc3_.rentOfferId;
            _loc4_ = true;
         }
         if(_loc2_ == -1)
         {
            return null;
         }
         return new FurnitureOffer(_loc3_,this,_loc2_,_loc4_,param1.productCode);
      }
      
      private function addMatchingNodesForOffer(param1:int, param2:Dictionary) : void
      {
         var _loc4_:Vector.<ICatalogNode> = currentCatalogNavigator.getNodesByOfferId(param1,true);
         if(_loc4_ == null)
         {
            return;
         }
         for each(var _loc3_ in _loc4_)
         {
            param2[_loc3_.pageId] = true;
         }
      }
      
      public function furniDataReady() : void
      {
         UnknownVarFromHabboCatalog_Vector_1 = _sessionDataManager.getFurniData(this);
         UnknownVarFromHabboCatalog_Boolean_13 = true;
         _pagesVisibleInBuilderMode = null;
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_STARTED":
               _privateRoomSessionActive = param1.session.isPrivateRoom;
               _roomSession = param1.session;
               if(_recycler != null)
               {
                  _recycler.setRoomSessionActive(true);
               }
               break;
            case "RSE_ENDED":
               _privateRoomSessionActive = false;
               _roomSession = null;
               if(_recycler != null)
               {
                  _recycler.setRoomSessionActive(false);
               }
         }
         dispatchRoomChangedToCatalogPages();
      }
      
      private function createRecycler() : void
      {
         _recycler = new RecyclerLogic(this,_windowManager);
      }
      
      private function createMarketPlace() : void
      {
         if(_marketPlace == null)
         {
            _marketPlace = new MarketPlaceLogic(this,_windowManager,_roomEngine);
         }
      }
      
      private function createClubGiftController() : void
      {
         if(_clubGiftController == null)
         {
            _clubGiftController = new ClubGiftController(this);
         }
      }
      
      private function createClubBuyController() : void
      {
         if(_clubBuyController == null)
         {
            _clubBuyController = new ClubBuyController(this,connection);
         }
      }
      
      private function createClubExtendController() : void
      {
         if(_clubExtendController == null)
         {
            _clubExtendController = new ClubExtendController(this);
         }
      }
      
      private function createGroupMembershipsController() : void
      {
         if(_groupMembershipsController == null)
         {
            _groupMembershipsController = new GuildMembershipsController(this);
         }
      }
      
      private function getGiftWrappingConfiguration() : void
      {
         send(new GetGiftWrappingConfigurationComposer());
      }
      
      public function getHabboClubOffers(param1:int) : void
      {
         send(new GetClubOffersMessageComposer(param1));
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideMainWindow();
         if(_recycler != null && getCurrentLayoutCode() == "recycler")
         {
            _recycler.cancel();
            setupInventoryForRecycler(false);
         }
      }
      
      private function onCatalogIndex(param1:CatalogIndexMessageEvent) : void
      {
         var _loc2_:CatalogWindowState = getCatalogState(param1.catalogType);
         if(_loc2_ == null || _loc2_.catalogNavigator == null)
         {
            return;
         }
         UnknownVarFromHabboCatalog_Boolean_7 = param1.newAdditionsAvailable;
         _loc2_.catalogNavigator.buildCatalogIndex(param1.root);
         if(param1.catalogType == _catalogType)
         {
            _loc2_.catalogNavigator.showIndex();
         }
         switch(_loc2_.UnknownVarFromCatalogWindowState_RequestedPage_1.requestType)
         {
            case 0:
               if(UnknownVarFromHabboCatalog_Boolean_7 && UnknownVarFromHabboCatalog_Boolean_8 && !newAdditionsPageOpenDisabled && param1.catalogType == "NORMAL")
               {
                  events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_SHOW"));
                  openCatalogPage("new_additions");
               }
               else
               {
                  _loc2_.catalogNavigator.loadFrontPage();
               }
               break;
            case 1:
               _loc2_.catalogNavigator.openPageById(_loc2_.UnknownVarFromCatalogWindowState_RequestedPage_1.requestId,_loc2_.UnknownVarFromCatalogWindowState_RequestedPage_1.requestedOfferId);
               _loc2_.UnknownVarFromCatalogWindowState_RequestedPage_1.resetRequest();
               break;
            case 2:
               _loc2_.catalogNavigator.openPage(_loc2_.UnknownVarFromCatalogWindowState_RequestedPage_1.requestName);
               _loc2_.UnknownVarFromCatalogWindowState_RequestedPage_1.resetRequest();
         }
      }
      
      private function onCatalogPage(param1:CatalogPageMessageEvent) : void
      {
         var _loc10_:* = undefined;
         var _loc11_:IProductData = null;
         var _loc8_:IFurnitureData = null;
         var _loc12_:Offer = null;
         var _loc13_:CatalogPageMessageParser = param1.getParser();
         var _loc17_:CatalogWindowState = getCatalogState(_loc13_.catalogType);
         if(_loc17_ == null || _loc17_.catalogViewer == null)
         {
            return;
         }
         var _loc9_:int = _loc13_.pageId;
         var _loc4_:String = _loc13_.layoutCode;
         var _loc5_:Array = _loc13_.localization.images.concat();
         var _loc14_:Array = _loc13_.localization.texts.concat();
         var _loc2_:IPageLocalization = new PageLocalization(_loc5_,_loc14_);
         var _loc15_:int = _loc13_.offerId;
         var _loc6_:Boolean = _loc13_.acceptSeasonCurrencyAsCredits;
         var _loc3_:Vector.<UnknownIHabboCatalog1> = new Vector.<UnknownIHabboCatalog1>(0);
         for each(var _loc16_ in _loc13_.offers)
         {
            _loc10_ = new Vector.<IProduct>(0);
            _loc11_ = getProductData(_loc16_.localizationId);
            for each(var _loc7_ in _loc16_.products)
            {
               _loc8_ = getFurnitureData(_loc7_.furniClassId,_loc7_.productType);
               _loc10_.push(new Product(_loc7_.productType,_loc7_.furniClassId,_loc7_.extraParam,getProductCountOverride(_loc16_.localizationId,_loc8_,_loc7_.productCount),_loc11_,_loc8_,this,_loc7_.uniqueLimitedItem,_loc7_.uniqueLimitedItemSeriesSize,_loc7_.uniqueLimitedItemsLeft));
            }
            if(!(_loc10_.length == 0 && !HabboCatalogUtils.buildersClub(_loc16_.localizationId)))
            {
               _loc12_ = new Offer(_loc16_.offerId,_loc16_.localizationId,_loc16_.isRent,_loc16_.priceInCredits,_loc16_.priceInActivityPoints,_loc16_.activityPointType,_loc16_.priceInSilver,_loc16_.giftable,_loc16_.clubLevel,_loc10_,_loc16_.bundlePurchaseAllowed,this);
               if(_loc12_.productContainer != null && isOfferCompatibleWithCatalogType(_loc12_,_loc13_.catalogType))
               {
                  _loc3_.push(_loc12_);
               }
               else
               {
                  _loc12_.dispose();
               }
            }
         }
         if(_loc13_.frontPageItems != null && _loc13_.frontPageItems.length > 0)
         {
            _frontPageItems = _loc13_.frontPageItems;
         }
         if(_loc17_.lastPageRequestId == _loc9_)
         {
            _loc17_.catalogViewer.showCatalogPage(_loc9_,_loc4_,_loc2_,_loc3_,_loc15_,_loc6_);
         }
         setCatalogBusy(_loc13_.catalogType,false);
      }
      
      private function isOfferCompatibleWithCatalogType(param1:Offer, param2:String) : Boolean
      {
         return param2 == "NORMAL" || param1.pricingModel != "pricing_model_bundle" && param1.pricingModel != "pricing_model_multi";
      }
      
      private function onCatalogPublished(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:CatalogPublishedMessageEvent = param1 as CatalogPublishedMessageEvent;
         if(_loc2_.newFurniDataHash)
         {
            sessionDataManager.newFurniDataHash = _loc2_.newFurniDataHash;
         }
         UnknownVarFromHabboCatalog_Boolean_3 = true;
         var _loc3_:Boolean = mainWindowVisible();
         reset();
         if(_loc3_)
         {
            _windowManager.alert("${catalog.alert.published.title}","${catalog.alert.published.description}",0,alertDialogEventProcessor);
         }
         else if(_notifications)
         {
            _loc4_ = localization.getLocalization("catalog.alert.published.description");
            _notifications.addItem(_loc4_,"info","if_icon_temp_png");
         }
      }
      
      private function refreshFurniData() : void
      {
         sessionDataManager.refreshFurniData();
         UnknownVarFromHabboCatalog_Boolean_3 = false;
      }
      
      private function onNftStorePurchase(param1:NftStorePurchaseMessageEvent) : void
      {
         var _loc4_:IProductImageWidget = null;
         var _loc3_:String = null;
         var _loc2_:NftStorePurchaseMessageEventParser = param1.getParser();
         if(_loc2_.result == NftStorePurchaseMessageEventParser.UnknownVarFromNftStorePurchaseMessageEventParser_Int_2)
         {
            _windowManager.alert("${catalog.alert.purchaseerror.title}","${notification.nft.purchase.error}",0,null);
         }
         else
         {
            _loc4_ = UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.getNftImage();
            _loc3_ = _collectorHub.getProductName(_loc4_.productInfo);
            _notifications.addItem(_localization.getLocalizationWithParams("notifications.text.purchase.ok","","productName",_loc3_),"info","icon_curator_stamp_large_png");
         }
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.dispose();
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 = null;
         }
      }
      
      private function onPurchaseError(param1:IMessageEvent) : void
      {
         var _loc3_:PurchaseErrorMessageEvent = param1 as PurchaseErrorMessageEvent;
         var _loc2_:PurchaseErrorMessageParser = _loc3_.getParser();
         var _loc4_:int = _loc2_.errorCode;
         var _loc5_:String = _loc4_ > 0 ? "${catalog.alert.purchaseerror.description." + _loc4_ + "}" : "${catalog.alert.purchaseerror.description}";
         _windowManager.alert("${catalog.alert.purchaseerror.title}",_loc5_,0,alertDialogEventProcessor);
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.dispose();
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 = null;
         }
      }
      
      private function onPurchaseNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:PurchaseNotAllowedMessageEvent = param1 as PurchaseNotAllowedMessageEvent;
         var _loc3_:PurchaseNotAllowedMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.errorCode;
         var _loc5_:String = "";
         switch(_loc4_ - 1)
         {
            case 0:
               _loc5_ = "${catalog.alert.purchasenotallowed.hc.description}";
               break;
            default:
               _loc5_ = "${catalog.alert.purchasenotallowed.unknown.description}";
         }
         _windowManager.alert("${catalog.alert.purchasenotallowed.title}",_loc5_,0,alertDialogEventProcessor);
      }
      
      private function onPurchaseOK(param1:IMessageEvent) : void
      {
         var _loc6_:IBitmapWrapperController = null;
         var _loc2_:BitmapData = null;
         var _loc7_:Point = null;
         var _loc5_:String = null;
         var _loc3_:PurchaseOKMessageEvent = param1 as PurchaseOKMessageEvent;
         var _loc4_:PurchaseOKMessageParser = _loc3_.getParser();
         events.dispatchEvent(new CatalogFurniPurchaseEvent(_loc4_.offer.localizationId));
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            if(!UnknownVarFromHabboCatalog_Boolean_6 && !UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.isGiftPurchase())
            {
               _loc6_ = UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.getIconWrapper();
               if(_loc6_)
               {
                  _loc2_ = _loc6_.bitmap;
                  if(_loc2_)
                  {
                     _loc7_ = new Point();
                     _loc6_.getGlobalPosition(_loc7_);
                     _loc5_ = "HTIE_ICON_INVENTORY";
                     if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.productType == "e")
                     {
                        _loc5_ = "HTIE_ICON_MEMENU";
                     }
                     _toolbar.createTransitionToIcon(_loc5_,_loc2_.clone(),_loc7_.x,_loc7_.y);
                  }
               }
            }
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.ltdRaffleEnded();
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.dispose();
         }
         UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 = null;
      }
      
      private function onGiftReceiverNotFound(param1:GiftReceiverNotFoundEvent) : void
      {
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.receiverNotFound();
         }
      }
      
      private function onNotEnoughBalance(param1:IMessageEvent) : void
      {
         var _loc3_:NotEnoughBalanceMessageEvent = param1 as NotEnoughBalanceMessageEvent;
         var _loc2_:NotEnoughBalanceMessageParser = _loc3_.getParser();
         if(_loc2_.notEnoughCredits)
         {
            showNotEnoughCreditsAlert();
         }
         else if(_loc2_.notEnoughActivityPoints)
         {
            showNotEnoughActivityPointsAlert(_loc2_.activityPointType);
         }
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.notEnoughCredits();
         }
      }
      
      public function setLeftPaneVisibility(param1:Boolean) : void
      {
         if(!_mainContainer)
         {
            return;
         }
         var _loc2_:IWindowModel = _mainContainer.findChildByName("navigationContainer");
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = _mainContainer.findChildByName("searchContainer");
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function showNotEnoughCreditsAlert() : void
      {
         if(!_windowManager)
         {
            return;
         }
         _windowManager.confirm("${catalog.alert.notenough.title}","${catalog.alert.notenough.credits.description}",0,noCreditsConfirmDialogEventProcessor);
      }
      
      public function showNotEnoughActivityPointsAlert(param1:int) : void
      {
         var _loc2_:String = getActivityPointName(param1);
         var _loc3_:String = localization.getLocalizationWithParams("catalog.alert.notenough.activitypoints.title","","currencyname",_loc2_);
         var _loc4_:String = localization.getLocalizationWithParams("catalog.alert.notenough.activitypoints.description","","currencyname",_loc2_);
         if(param1 == 0)
         {
            _windowManager.confirm(_loc3_,_loc4_,0,noDucketsConfirmDialogEventProcessor);
         }
         else
         {
            _windowManager.alert(_loc3_,_loc4_,0,alertDialogEventProcessor);
         }
      }
      
      public function getActivityPointName(param1:int) : String
      {
         var _loc2_:String = getProperty("activitypoint.name." + param1);
         return localization.getLocalization(_loc2_,_loc2_);
      }
      
      private function onSilverBalance(param1:SilverBalanceMessageEvent) : void
      {
         var _loc2_:SilverBalanceMessageEventParser = param1.getParser();
         _purse.silverBalance = _loc2_.silverBalance;
         events.dispatchEvent(new PurseEvent("catalog_purse_silver_balance",_purse.silverBalance,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onEmeraldBalance(param1:EmeraldBalanceMessageEvent) : void
      {
         var _loc2_:EmeraldBalanceMessageEventParser = param1.getParser();
         _purse.emeraldBalance = _loc2_.emeraldBalance;
         events.dispatchEvent(new PurseEvent("catalog_purse_emerald_balance",_purse.emeraldBalance,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onVoucherRedeemOk(param1:VoucherRedeemOkMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = "${catalog.alert.voucherredeem.ok.description}";
         if(param1.productName != "")
         {
            _loc2_ = "catalog.alert.voucherredeem.ok.description.furni";
            _localization.registerParameter(_loc2_,"productName",param1.productName);
            _localization.registerParameter(_loc2_,"productDescription",param1.productDescription);
            _loc2_ = "${" + _loc2_ + "}";
         }
         _windowManager.alert("${catalog.alert.voucherredeem.ok.title}",_loc2_,0,alertDialogEventProcessor);
      }
      
      private function onVoucherRedeemError(param1:VoucherRedeemErrorMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = "${catalog.alert.voucherredeem.error.title}";
         var _loc3_:String = "${catalog.alert.voucherredeem.error.description." + param1.errorCode + "}";
         _windowManager.alert(_loc2_,_loc3_,0,alertDialogEventProcessor);
      }
      
      private function onApproveNameResult(param1:ApproveNameMessageEvent) : void
      {
         if(param1 == null || UnknownVarFromHabboCatalog_CatalogViewer_1 == null)
         {
            return;
         }
         var _loc2_:ApproveNameMessageParser = param1.getParser();
         UnknownVarFromHabboCatalog_CatalogViewer_1.dispatchWidgetEvent(new CatalogWidgetApproveNameResultEvent(_loc2_.result,_loc2_.nameValidationInfo));
      }
      
      private function onCreditBalance(param1:IMessageEvent) : void
      {
         var _loc3_:CreditBalanceEvent = param1 as CreditBalanceEvent;
         var _loc2_:CreditBalanceParser = _loc3_.getParser();
         _purse.credits = _loc2_.balance;
         updatePurse();
         if(!UnknownVarFromHabboCatalog_Boolean_5 && _soundManager != null)
         {
            _soundManager.playSound("HBST_purchase");
         }
         UnknownVarFromHabboCatalog_Boolean_5 = false;
         events.dispatchEvent(new PurseEvent("catalog_purse_credit_balance",_purse.credits,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onActivityPointNotification(param1:IMessageEvent) : void
      {
         var _loc2_:HabboActivityPointNotificationMessageEvent = param1 as HabboActivityPointNotificationMessageEvent;
         _purse.activityPoints[_loc2_.type] = _loc2_.amount;
         updatePurse();
         if(_soundManager != null && _loc2_.type == 0)
         {
            _soundManager.playSound("HBST_pixels");
         }
         events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance",_loc2_.amount,_loc2_.type));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onActivityPoints(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ActivityPointsMessageEvent = param1 as ActivityPointsMessageEvent;
         _purse.activityPoints = _loc3_.points;
         updatePurse();
         for(var _loc2_ in _loc3_.points)
         {
            _loc4_ = int(_loc2_);
            events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance",_loc3_.points[_loc4_],_loc4_));
         }
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:ScrSendUserInfoMessageParser = (param1 as ScrSendUserInfoEvent).getParser();
         _purse.clubDays = Math.max(0,_loc2_.daysToPeriodEnd);
         _purse.clubPeriods = Math.max(0,_loc2_.periodsSubscribedAhead);
         _purse.isVIP = _loc2_.isVIP;
         _purse.pastClubDays = _loc2_.pastClubDays;
         _purse.pastVipDays = _loc2_.pastVipDays;
         _purse.isExpiring = _loc2_.responseType == 3 ? true : false;
         _purse.minutesUntilExpiration = _loc2_.minutesUntilExpiration;
         _purse.minutesSinceLastModified = _loc2_.minutesSinceLastModified;
         if(ExternalInterface.available)
         {
            if(_loc2_.productName == "habbo_club" || _loc2_.productName == "club_habbo")
            {
               _loc3_ = _loc2_.isVIP && _loc2_.minutesUntilExpiration > 0;
               ExternalInterface.call("FlashExternalInterface.subscriptionUpdated",_loc3_);
            }
         }
         updatePurse();
         if(_loc2_.responseType == 2)
         {
            reset();
            if(UnknownVarFromHabboCatalog_String_2 != null)
            {
               openCatalogPage(UnknownVarFromHabboCatalog_String_2);
               UnknownVarFromHabboCatalog_String_2 = null;
            }
         }
      }
      
      private function onClubGiftInfo(param1:ClubGiftInfoEvent) : void
      {
         if(!param1 || !_clubGiftController)
         {
            return;
         }
         var _loc2_:ClubGiftInfoParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         _clubGiftController.setInfo(_loc2_.daysUntilNextGift,_loc2_.giftsAvailable,_loc2_.offers,_loc2_.giftData);
      }
      
      private function onRecyclerStatus(param1:IMessageEvent) : void
      {
         var _loc2_:RecyclerStatusMessageParser = (param1 as RecyclerStatusMessageEvent).getParser();
         if(_loc2_ == null || _recycler == null)
         {
            return;
         }
         _recycler.setSystemStatus(_loc2_.recyclerStatus,_loc2_.recyclerTimeoutSeconds);
      }
      
      private function onRecyclerFinished(param1:IMessageEvent) : void
      {
         var _loc2_:RecyclerFinishedMessageParser = (param1 as RecyclerFinishedMessageEvent).getParser();
         if(_loc2_ == null || _recycler == null)
         {
            return;
         }
         _recycler.setFinished(_loc2_.recyclerFinishedStatus,_loc2_.prizeId);
      }
      
      private function onRecyclerPrizes(param1:IMessageEvent) : void
      {
         var _loc2_:RecyclerPrizesMessageParser = (param1 as RecyclerPrizesMessageEvent).getParser();
         if(_loc2_ == null || _recycler == null)
         {
            return;
         }
         _recycler.storePrizeTable(_loc2_.prizeLevels);
      }
      
      private function onMarketPlaceOffers(param1:IMessageEvent) : void
      {
         if(_marketPlace != null)
         {
            _marketPlace.onOffers(param1);
         }
      }
      
      private function onMarketPlaceOwnOffers(param1:IMessageEvent) : void
      {
         if(_marketPlace != null)
         {
            _marketPlace.onOwnOffers(param1);
         }
      }
      
      private function onMarketPlaceBuyResult(param1:IMessageEvent) : void
      {
         if(_marketPlace != null)
         {
            _marketPlace.onBuyResult(param1);
         }
      }
      
      private function onMarketPlaceCancelResult(param1:IMessageEvent) : void
      {
         if(_marketPlace != null)
         {
            _marketPlace.onCancelResult(param1);
         }
      }
      
      private function onMarketPlaceCancelAllResult(param1:IMessageEvent) : void
      {
         if(_marketPlace != null)
         {
            _marketPlace.onCancelAllResult(param1);
         }
      }
      
      private function onMarketPlaceClearOwnHistoryResult(param1:IMessageEvent) : void
      {
         if(_marketPlace != null)
         {
            _marketPlace.onClearOwnHistoryResult(param1);
         }
      }
      
      private function onGiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         _giftWrappingConfiguration = new GiftWrappingConfiguration(param1);
      }
      
      private function onMarketplaceItemStats(param1:MarketplaceItemStatsEvent) : void
      {
         if(!param1 || !_marketPlace)
         {
            return;
         }
         var _loc2_:MarketplaceItemStatsParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
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
         _marketPlace.itemStats = _loc3_;
      }
      
      private function onMarketplaceConfiguration(param1:MarketplaceConfigurationEvent) : void
      {
         if(!param1 || !_marketPlace)
         {
            return;
         }
         var _loc2_:MarketplaceConfigurationParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         _marketPlace.averagePricePeriod = _loc2_.averagePricePeriod;
      }
      
      private function onMarketplaceMakeOfferResult(param1:MarketplaceMakeOfferResult) : void
      {
         if(!param1 || !_marketPlace)
         {
            return;
         }
         var _loc2_:MarketplaceMakeOfferResultParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.result == 1)
         {
            _marketPlace.refreshOffers();
         }
      }
      
      private function onHabboClubOffers(param1:HabboClubOffersMessageEvent) : void
      {
         var _loc2_:HabboClubOffersMessageParser = param1.getParser();
         if(_clubBuyController != null && (_loc2_.source == 0 || _loc2_.source == 1 || _loc2_.source == 2 || _loc2_.source == 6))
         {
            _clubBuyController.onOffers(_loc2_);
         }
      }
      
      private function onHabboClubExtendOffer(param1:HabboClubExtendOfferMessageEvent) : void
      {
         if(!UnknownVarFromHabboCatalog_Boolean_1)
         {
            init();
         }
         if(_clubExtendController)
         {
            _clubExtendController.onOffer(param1);
         }
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
      }
      
      private function onSellablePalettes(param1:SellablePetPalettesMessageEvent) : void
      {
         var _loc2_:SellablePetPalettesParser = param1.getParser();
         _sellablePetPalettes.remove(_loc2_.productCode);
         var _loc3_:Array = _loc2_.sellablePalettes;
         if(_loc3_ != null)
         {
            _sellablePetPalettes.add(_loc2_.productCode,_loc3_.slice());
            if(UnknownVarFromHabboCatalog_CatalogViewer_1 != null && UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage != null)
            {
               UnknownVarFromHabboCatalog_CatalogViewer_1.dispatchWidgetEvent(new CatalogWidgetSellablePetPalettesEvent(_loc2_.productCode,_loc3_.slice()));
            }
         }
      }
      
      private function setElementImage(param1:String, param2:BitmapData) : void
      {
         setElementImageForContainer(_mainContainer,param1,param2);
      }
      
      private function setElementImageForContainer(param1:IWindowController_1, param2:String, param3:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc4_:IBitmapWrapperController = param1.findChildByName(param2) as IBitmapWrapperController;
         if(_loc4_ != null)
         {
            _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc4_.bitmap.copyPixels(param3,param3.rect,new Point(0,0));
         }
         else
         {
            Logger.log("Could not find element: " + param2);
         }
      }
      
      private function alertDialogEventProcessor(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
         resetPlacedOfferData();
      }
      
      private function noCreditsConfirmDialogEventProcessor(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         resetPlacedOfferData();
         if(param2.type == "WE_OK")
         {
            HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
         }
      }
      
      private function noDucketsConfirmDialogEventProcessor(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         var _loc3_:String = null;
         param1.dispose();
         resetPlacedOfferData();
         if(param2.type == "WE_OK")
         {
            _loc3_ = getProperty("link.format.duckets");
            if(_loc3_ != "")
            {
               _windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
               HabboWebTools.navigateToURL(_loc3_,"habboMain");
            }
         }
      }
      
      private function onExternalLink(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      public function redeemVoucher(param1:String) : void
      {
         var _loc2_:IMessageComposer = new RedeemVoucherMessageComposer(param1);
         send(_loc2_);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      public function productDataReady() : void
      {
         var _loc2_:String = null;
         var _loc1_:Boolean = false;
         var _loc3_:Boolean = false;
         UnknownVarFromHabboCatalog_Boolean_2 = true;
         UnknownVarFromHabboCatalog_Boolean_13 = true;
         events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
         if(_catalogStates == null && UnknownVarFromHabboCatalog_String_3 != null)
         {
            _loc2_ = UnknownVarFromHabboCatalog_String_3;
            _loc1_ = UnknownVarFromHabboCatalog_Boolean_11;
            _loc3_ = UnknownVarFromHabboCatalog_Boolean_12;
            UnknownVarFromHabboCatalog_String_3 = null;
            toggleCatalog(_loc2_,_loc1_,_loc3_);
         }
      }
      
      public function isDraggable(param1:UnknownIHabboCatalog1) : Boolean
      {
         return getBoolean("catalog.drag_and_drop") && _roomSession != null && (UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage == null || UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage.allowDragging) && (_catalogType == "NORMAL" && (_roomSession.isRoomOwner || _roomSession.isGuildRoom && _roomSession.roomControllerLevel >= 2) || _catalogType == "BUILDERS_CLUB" && getBuilderFurniPlaceableStatusForOffer(param1) == 0) && param1.pricingModel != "pricing_model_bundle" && param1.pricingModel != "pricing_model_multi" && param1.product != null && param1.product.productType != "e" && param1.product.productType != "h";
      }
      
      public function getBuilderFurniPlaceableStatusForOffer(param1:UnknownIHabboCatalog1) : int
      {
         if(param1 == null)
         {
            return 1;
         }
         if(builderFurniCount < 0 || builderFurniCount >= builderFurniLimit)
         {
            return 2;
         }
         if(roomSession == null)
         {
            return 3;
         }
         return getBuilderFurniPlaceableStatus();
      }
      
      public function getBuilderFurniPlaceableStatus() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IRoomObject = null;
         var _loc1_:IUserData = null;
         if(!roomSession.isRoomOwner && roomSession.isGuildRoom && !getBoolean("builders.club.furniture.placement.group.room.enabled"))
         {
            return 5;
         }
         if(roomSession.roomControllerLevel < 3)
         {
            return 4;
         }
         if(builderSecondsLeft <= 0)
         {
            _loc2_ = roomEngine.getRoomObjectCount(roomSession.roomId,100);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = roomEngine.getRoomObjectWithIndex(roomSession.roomId,_loc3_,100);
               _loc1_ = roomSession.userDataManager.getUserDataByIndex(_loc4_.getId());
               if(_loc1_ != null && _loc1_.type == 1 && _loc1_.roomObjectId != roomSession.ownUserRoomId && !_loc1_.isModerator)
               {
                  return 6;
               }
               _loc3_++;
            }
         }
         return 0;
      }
      
      public function canPlaceWithBC() : Boolean
      {
         return getBuilderFurniPlaceableStatus() == 0;
      }
      
      private function updateRoom(param1:String, param2:String) : void
      {
         var _loc4_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
         var _loc5_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
         var _loc3_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
         _loc4_ = _loc4_ && _loc4_.length > 0 ? _loc4_ : "101";
         _loc5_ = _loc5_ && _loc5_.length > 0 ? _loc5_ : "101";
         _loc3_ = _loc3_ && _loc3_.length > 0 ? _loc3_ : "1.1";
         switch(param1)
         {
            case "floor":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,param2,_loc4_,_loc3_,true);
               break;
            case "wallpaper":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,param2,_loc3_,true);
               break;
            case "landscape":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,_loc4_,param2,true);
               break;
            default:
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,_loc4_,_loc3_,true);
         }
      }
      
      public function requestSelectedItemToMover(param1:UnknownIHabboCatalogViewer1, param2:UnknownIHabboCatalog1, param3:Boolean = false) : void
      {
         var _loc6_:int = 0;
         if(!isDraggable(param2))
         {
            return;
         }
         var _loc4_:IProduct;
         switch((_loc4_ = param2.product).productType)
         {
            case "s":
               _loc6_ = 10;
               break;
            case "i":
               _loc6_ = 20;
         }
         var _loc5_:Boolean = _roomEngine.initializeRoomObjectInsert("catalog",-param2.offerId,_loc6_,_loc4_.productClassId,!!_loc4_.extraParam ? _loc4_.extraParam.toString() : null,null,-1,-1,null,param3);
         if(_loc5_)
         {
            _offerInFurniPlacing = param2;
            _offerPlacingCallbackReceiver = param1;
            hideMainWindow();
            UnknownVarFromHabboCatalog_Boolean_6 = true;
            UnknownVarFromHabboCatalog_Boolean_14 = param3;
         }
      }
      
      private function onObjectSelected(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:IUserData = null;
         if(param1 == null)
         {
            return;
         }
         if(buildersClubEnabled && (!UnknownVarFromHabboCatalog_Boolean_1 || !getCatalogNavigator("BUILDERS_CLUB").initialized))
         {
            init();
            refreshCatalogIndex("BUILDERS_CLUB");
         }
         if(param1.type == "REOE_SELECTED" && param1.category == 100)
         {
            _loc2_ = getUserDataForEvent(param1);
            if(_loc2_ != null)
            {
               events.dispatchEvent(new CatalogUserEvent("CATALOG_USER_SELECTED",_loc2_.webID,_loc2_.name));
            }
         }
      }
      
      private function onFriendBarSelectionEvent(param1:FriendBarSelectionEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc4_:UnknownIHabboCatalogViewer1 = null;
         if(UnknownVarFromHabboCatalog_Boolean_6 && param1.type == "FBVE_FRIEND_SELECTED")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc3_ = param1.friendId;
            _loc2_ = param1.friendName;
            _loc4_ = _offerPlacingCallbackReceiver;
            if(_loc4_ != null)
            {
               _loc4_.onDragAndDropDone(true,_loc2_);
            }
            resetObjectMover(false);
            cancelFurniInMover();
         }
      }
      
      private function getUserDataForEvent(param1:RoomEngineObjectEvent) : IUserData
      {
         var _loc3_:IRoomSession = null;
         var _loc2_:IUserData = null;
         if(_roomSessionManager != null)
         {
            _loc3_ = _roomSessionManager.getSession(param1.roomId);
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.userDataManager.getUserDataByIndex(param1.objectId);
            }
         }
         return _loc2_;
      }
      
      private function onObjectPlaceOnUser(param1:RoomEngineObjectPlacedOnUserEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:IUserData = null;
         var _loc3_:UnknownIHabboCatalogViewer1 = null;
         if(UnknownVarFromHabboCatalog_Boolean_6 && param1.type == "REOE_PLACED_ON_USER")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc4_ = null;
            _loc2_ = getUserDataForEvent(param1);
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.name;
            }
            _loc3_ = _offerPlacingCallbackReceiver;
            if(_loc3_ != null)
            {
               _loc3_.onDragAndDropDone(true,_loc4_);
            }
            resetObjectMover(false);
            cancelFurniInMover();
         }
      }
      
      private function onObjectPlacedInRoom(param1:RoomEngineObjectPlacedEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:IProduct = null;
         var _loc5_:Boolean = false;
         var _loc6_:UnknownIHabboCatalogViewer1 = null;
         var _loc4_:IRoomObjectController = null;
         var _loc8_:int = 0;
         var _loc3_:* = undefined;
         if(UnknownVarFromHabboCatalog_Boolean_6 && param1.type == "REOE_PLACED" && param1.placementSource == "catalog")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc7_ = param1.category;
            _loc2_ = _offerInFurniPlacing.product;
            _loc5_ = false;
            if(_loc7_ == 20)
            {
               switch(_loc2_.furnitureData.className)
               {
                  case "floor":
                  case "wallpaper":
                  case "landscape":
                     _loc5_ = param1.placedOnFloor || param1.placedOnWall;
                     break;
                  default:
                     _loc5_ = param1.placedInRoom;
               }
            }
            else
            {
               _loc5_ = param1.placedInRoom;
            }
            if(!_loc5_)
            {
               resetObjectMover();
               return;
            }
            UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1 = new PlacedObjectPurchaseData(param1.roomId,param1.objectId,param1.category,param1.wallLocation,param1.x,param1.y,param1.direction,_offerInFurniPlacing);
            _loc6_ = _offerPlacingCallbackReceiver;
            if(_loc6_ != null)
            {
               _loc6_.onDragAndDropDone(true,null);
            }
            switch(_catalogType)
            {
               case "NORMAL":
                  if(_loc7_ == 10)
                  {
                     _roomEngine.addObjectFurniture(param1.roomId,param1.objectId,_loc2_.productClassId,new Vector3d(param1.x,param1.y,param1.z),new Vector3d(param1.direction,0,0),0,new LegacyStuffData());
                  }
                  else if(_loc7_ == 20)
                  {
                     switch(_loc2_.furnitureData.className)
                     {
                        case "floor":
                        case "wallpaper":
                        case "landscape":
                           updateRoom(_loc2_.furnitureData.className,_loc2_.extraParam);
                           break;
                        default:
                           _roomEngine.addObjectWallItem(param1.roomId,param1.objectId,_loc2_.productClassId,new Vector3d(param1.x,param1.y,param1.z),new Vector3d(param1.direction * 45,0,0),0,param1.instanceData,0);
                     }
                  }
                  _loc4_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category) as IRoomObjectController;
                  if(_loc4_)
                  {
                     _loc4_.getModelController().setNumber("furniture_alpha_multiplier",0.5);
                  }
                  break;
               case "BUILDERS_CLUB":
                  _loc8_ = _offerInFurniPlacing.page.pageId;
                  if(_loc8_ == -12345678)
                  {
                     _loc3_ = currentCatalogNavigator.getNodesByOfferId(_offerInFurniPlacing.offerId,true);
                     if(_loc3_ != null)
                     {
                        _loc8_ = _loc3_[0].pageId;
                     }
                  }
                  switch(_loc7_ - 10)
                  {
                     case 0:
                        send(new BuildersClubPlaceRoomItemMessageComposer(_loc8_,_offerInFurniPlacing.offerId,_loc2_.extraParam,param1.x,param1.y,param1.direction));
                        break;
                     case 10:
                        send(new BuildersClubPlaceWallItemMessageComposer(_loc8_,_offerInFurniPlacing.offerId,_loc2_.extraParam,param1.wallLocation));
                  }
                  if(UnknownVarFromHabboCatalog_Boolean_14)
                  {
                     requestSelectedItemToMover(_loc6_,_offerInFurniPlacing,true);
                  }
                  else
                  {
                     toggleBuilderCatalog();
                  }
            }
         }
      }
      
      private function resetObjectMover(param1:Boolean = true) : void
      {
         var _loc2_:CatalogWindowState = null;
         if(param1 && UnknownVarFromHabboCatalog_Boolean_6)
         {
            _loc2_ = getCatalogState(_catalogType);
            showMainWindow(_loc2_);
            dispatchRoomChangedToCatalogPage(_loc2_);
         }
         UnknownVarFromHabboCatalog_Boolean_6 = false;
         _offerPlacingCallbackReceiver = null;
      }
      
      public function syncPlacedOfferWithPurchase(param1:UnknownIHabboCatalog1) : void
      {
         if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1)
         {
            if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.offerId != param1.offerId)
            {
               resetPlacedOfferData();
            }
         }
      }
      
      public function resetPlacedOfferData(param1:Boolean = false) : void
      {
         if(!param1)
         {
            resetObjectMover();
         }
         if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1 != null)
         {
            if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.category == 10)
            {
               _roomEngine.disposeObjectFurniture(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.roomId,UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.objectId);
            }
            else if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.category == 20)
            {
               switch(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.furniData.className)
               {
                  case "floor":
                  case "wallpaper":
                  case "landscape":
                     updateRoom("reset","");
                     break;
                  default:
                     _roomEngine.disposeObjectWallItem(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.roomId,UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.objectId);
               }
            }
            else
            {
               _roomEngine.deleteRoomObject(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.objectId,UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.category);
            }
            UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.dispose();
            UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1 = null;
         }
      }
      
      public function cancelFurniInMover() : void
      {
         if(_offerInFurniPlacing != null)
         {
            _roomEngine.cancelRoomObjectInsert();
            UnknownVarFromHabboCatalog_Boolean_6 = false;
            _offerInFurniPlacing = null;
         }
      }
      
      public function get collectorHub() : ICollectiblesController
      {
         return _collectorHub;
      }
      
      public function get specialItemsController() : SpecialItemsController
      {
         return _specialItemsController;
      }
      
      public function itemAddedToInventory(param1:int, param2:int, param3:int) : void
      {
         var _loc8_:* = 0;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1 != null && UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.productClassId == param1)
         {
            if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.roomId == _roomEngine.activeRoomId)
            {
               _loc8_ = param2;
               param3 = UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.category;
               _loc6_ = UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.wallLocation;
               _loc5_ = UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.x;
               _loc7_ = UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.y;
               _loc10_ = UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.direction;
               switch(param3 - 2)
               {
                  case 0:
                     _loc9_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
                     if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.extraParameter != _loc9_)
                     {
                        send(new RequestRoomPropertySet(_loc8_));
                     }
                     break;
                  case 1:
                     _loc11_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
                     if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.extraParameter != _loc11_)
                     {
                        send(new RequestRoomPropertySet(_loc8_));
                     }
                     break;
                  case 2:
                     _loc4_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
                     if(UnknownVarFromHabboCatalog_PlacedObjectPurchaseData_1.extraParameter != _loc4_)
                     {
                        send(new RequestRoomPropertySet(_loc8_));
                     }
                     break;
                  default:
                     send(new PlaceObjectMessageComposer(_loc8_,param3,_loc6_,_loc5_,_loc7_,_loc10_));
               }
               resetPlacedOfferData();
            }
         }
      }
      
      public function setImageFromAsset(param1:IWindowModel, param2:String, param3:Function) : void
      {
         if(!param2 || !assets)
         {
            return;
         }
         var _loc4_:BitmapDataAsset = assets.getAssetByName(param2) as BitmapDataAsset;
         if(_loc4_ == null)
         {
            retrievePreviewAsset(param2,param3);
            return;
         }
         if(param1)
         {
            HabboCatalog.setElementImageCentered(param1,_loc4_.content as BitmapData);
         }
      }
      
      public function get imageGalleryHost() : String
      {
         return getProperty("image.library.catalogue.url");
      }
      
      private function retrievePreviewAsset(param1:String, param2:Function) : void
      {
         if(!param1 || !assets)
         {
            return;
         }
         var _loc5_:String = imageGalleryHost + param1 + ".png";
         var _loc3_:URLRequest = new URLRequest(_loc5_);
         var _loc4_:AssetLoaderStruct = assets.loadAssetFromFile(param1,_loc3_,"image/png");
         if(!_loc4_)
         {
            return;
         }
         if(param2 != null)
         {
            _loc4_.addEventListener("AssetLoaderEventComplete",param2);
         }
      }
      
      private function showMainWindow(param1:CatalogWindowState = null) : void
      {
         var _loc2_:IDesktopController = null;
         if(param1 == null)
         {
            param1 = getCatalogState(_catalogType);
         }
         if(_windowManager != null && param1 != null && param1.mainContainer != null && param1.mainContainer.parent == null)
         {
            _loc2_ = _windowManager.getDesktop(1);
            if(_loc2_ != null)
            {
               applyCatalogWindowPosition(param1.mainContainer);
               param1.mainContainer.visible = true;
               _loc2_.addChild(param1.mainContainer);
            }
         }
      }
      
      private function hideMainWindow(param1:CatalogWindowState = null, param2:Boolean = true) : void
      {
         var _loc3_:IDesktopController = null;
         if(param1 == null)
         {
            param1 = getCatalogState(_catalogType);
         }
         if(_windowManager != null && param1 != null && param1.mainContainer != null && param1.mainContainer.parent != null)
         {
            _loc3_ = _windowManager.getDesktop(1);
            if(_loc3_ != null && !UnknownVarFromHabboCatalog_Boolean_9)
            {
               storeCatalogWindowPosition(param1.mainContainer);
               param1.mainContainer.visible = false;
               _loc3_.removeChild(param1.mainContainer);
               if(param2 && param1.catalogViewer != null)
               {
                  param1.catalogViewer.catalogWindowClosed();
               }
            }
            UnknownVarFromHabboCatalog_Boolean_9 = false;
         }
      }
      
      private function mainWindowVisible(param1:String = null) : Boolean
      {
         return isMainWindowVisible(getCatalogState(param1 == null ? _catalogType : param1));
      }
      
      private function isMainWindowVisible(param1:CatalogWindowState) : Boolean
      {
         return _windowManager != null && param1 != null && param1.mainContainer != null && param1.mainContainer.parent != null;
      }
      
      private function getCatalogState(param1:String) : CatalogWindowState
      {
         return _catalogStates != null ? _catalogStates[param1] : null;
      }
      
      private function ensureCatalogState(param1:String) : CatalogWindowState
      {
         if(_catalogStates == null)
         {
            _catalogStates = new Dictionary();
         }
         if(_catalogNavigators == null)
         {
            _catalogNavigators = new Dictionary();
         }
         return getCatalogState(param1) ?? createCatalogWindowState(param1);
      }
      
      private function setActiveCatalogState(param1:String) : CatalogWindowState
      {
         _catalogType = param1;
         var _loc2_:CatalogWindowState = ensureCatalogState(param1);
         _mainContainer = _loc2_?.mainContainer;
         UnknownVarFromHabboCatalog_CatalogViewer_1 = _loc2_?.catalogViewer;
         return _loc2_;
      }
      
      private function storeCatalogWindowPosition(param1:IWindowModel) : void
      {
         if(param1 == null || UnknownVarFromHabboCatalog_Boolean_10)
         {
            return;
         }
         if(UnknownVarFromHabboCatalog_Point_1 != null && UnknownVarFromHabboCatalog_Point_1.x == param1.x && UnknownVarFromHabboCatalog_Point_1.y == param1.y)
         {
            return;
         }
         UnknownVarFromHabboCatalog_Point_1 = new Point(param1.x,param1.y);
         syncCatalogWindowPositions();
      }
      
      private function applyCatalogWindowPosition(param1:IWindowModel) : void
      {
         if(param1 != null && UnknownVarFromHabboCatalog_Point_1 != null)
         {
            setCatalogWindowPosition(param1,UnknownVarFromHabboCatalog_Point_1);
         }
      }
      
      private function syncCatalogWindowPositions() : void
      {
         if(_catalogStates == null || UnknownVarFromHabboCatalog_Point_1 == null)
         {
            return;
         }
         for each(var _loc1_ in _catalogStates)
         {
            if(_loc1_.mainContainer != null)
            {
               setCatalogWindowPosition(_loc1_.mainContainer,UnknownVarFromHabboCatalog_Point_1);
            }
         }
      }
      
      private function onMainWindowRelocate(param1:WindowEvent) : void
      {
         if(UnknownVarFromHabboCatalog_Boolean_10)
         {
            return;
         }
         storeCatalogWindowPosition(param1.target as IWindowModel);
      }
      
      private function setCatalogWindowPosition(param1:IWindowModel, param2:Point) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(param1.x == param2.x && param1.y == param2.y)
         {
            return;
         }
         UnknownVarFromHabboCatalog_Boolean_10 = true;
         param1.position = param2.clone();
         UnknownVarFromHabboCatalog_Boolean_10 = false;
      }
      
      private function dispatchRoomChangedToCatalogPages() : void
      {
         if(_catalogStates == null)
         {
            return;
         }
         for each(var _loc1_ in _catalogStates)
         {
            dispatchRoomChangedToCatalogPage(_loc1_);
         }
      }
      
      private function dispatchRoomChangedToCatalogPage(param1:CatalogWindowState) : void
      {
         if(param1 != null && param1.catalogViewer != null && param1.catalogViewer.currentPage != null)
         {
            param1.catalogViewer.currentPage.dispatchWidgetEvent(new CatalogWidgetRoomChangedEvent());
         }
      }
      
      private function dispatchBuilderSubscriptionUpdatedToCatalogPages() : void
      {
         if(_catalogStates == null)
         {
            return;
         }
         for each(var _loc1_ in _catalogStates)
         {
            if(_loc1_ != null && _loc1_.catalogViewer != null && _loc1_.catalogViewer.currentPage != null)
            {
               _loc1_.catalogViewer.currentPage.dispatchWidgetEvent(new CatalogWidgetBuilderSubscriptionUpdatedEvent());
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(UnknownVarFromHabboCatalog_RoomPreviewer_1 != null)
         {
            UnknownVarFromHabboCatalog_RoomPreviewer_1.updatePreviewRoomView();
         }
         if(getTimer() - _builderMembershipDisplayUpdateTime > 500)
         {
            _loc3_ = builderSecondsLeft;
            _loc2_ = builderSecondsLeftWithGrace;
            if(_loc3_ > -3 && _loc3_ < 200 || _loc2_ > -3 && _loc2_ < 200)
            {
               refreshBuilderStatus();
            }
         }
      }
      
      public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         if(_groupMembershipsController)
         {
            _groupMembershipsController.onGuildMembershipsMessageEvent(param1);
         }
      }
      
      private function onSnowWarGameTokenOffer(param1:SnowWarGameTokensMessageEvent) : void
      {
         var _loc3_:SnowWarGameTokensMessageParser = param1.getParser();
         disposeSnowWarTokens();
         for each(var _loc2_ in _loc3_.offers)
         {
            if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS")
            {
               UnknownVarFromHabboCatalog_GameTokensOffer_1 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
            else if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS2")
            {
               UnknownVarFromHabboCatalog_GameTokensOffer_2 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
            else if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS3")
            {
               UnknownVarFromHabboCatalog_GameTokensOffer_3 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
         }
      }
      
      public function buySnowWarTokensOffer(param1:String) : void
      {
         if(param1 == "GET_SNOWWAR_TOKENS" && UnknownVarFromHabboCatalog_GameTokensOffer_1)
         {
            showPurchaseConfirmation(UnknownVarFromHabboCatalog_GameTokensOffer_1,-1,UnknownVarFromHabboCatalog_GameTokensOffer_1.localizationId);
         }
         else if(param1 == "GET_SNOWWAR_TOKENS2" && UnknownVarFromHabboCatalog_GameTokensOffer_2)
         {
            showPurchaseConfirmation(UnknownVarFromHabboCatalog_GameTokensOffer_2,-1,UnknownVarFromHabboCatalog_GameTokensOffer_2.localizationId);
         }
         else if(param1 == "GET_SNOWWAR_TOKENS3" && UnknownVarFromHabboCatalog_GameTokensOffer_3)
         {
            showPurchaseConfirmation(UnknownVarFromHabboCatalog_GameTokensOffer_3,-1,UnknownVarFromHabboCatalog_GameTokensOffer_3.localizationId);
         }
         else
         {
            _communication.connection.send(new GetSnowWarGameTokensOfferComposer());
         }
      }
      
      public function verifyClubLevel(param1:int = 1) : Boolean
      {
         if(_sessionDataManager.clubLevel >= param1)
         {
            return true;
         }
         openClubCenter();
         return false;
      }
      
      public function openClubCenter() : void
      {
         context.createLinkEvent("habboUI/open/hccenter");
      }
      
      public function openVault() : void
      {
         context.createLinkEvent("habboUI/open/vault");
      }
      
      private function onGuildVisualSettingsChanged(param1:GuildSettingsChangedInManageEvent) : void
      {
         if(_groupMembershipsController)
         {
            _groupMembershipsController.onGuildVisualSettingsChanged(param1.guildId);
         }
      }
      
      public function get avatarEditor() : IHabboAvatarEditorManager
      {
         return _avatarEditor;
      }
      
      public function checkGiftable(param1:UnknownIHabboCatalog1) : void
      {
         send(new GetIsOfferGiftableComposer(param1.offerId));
      }
      
      public function rememberPageDuringVipPurchase(param1:int) : void
      {
         var _loc2_:ICatalogNode = currentCatalogNavigator.getNodeById(param1);
         if(_loc2_)
         {
            UnknownVarFromHabboCatalog_String_2 = _loc2_.pageName;
         }
         else
         {
            UnknownVarFromHabboCatalog_String_2 = "frontpage";
         }
      }
      
      public function forgetPageDuringVipPurchase() : void
      {
         UnknownVarFromHabboCatalog_String_2 = null;
         UnknownVarFromHabboCatalog_Boolean_9 = false;
      }
      
      public function doNotCloseAfterVipPurchase() : void
      {
         UnknownVarFromHabboCatalog_Boolean_9 = UnknownVarFromHabboCatalog_String_2 != null;
      }
      
      private function initBundleDiscounts() : void
      {
         sendGetBundleDiscountRuleset();
      }
      
      private function sendGetBundleDiscountRuleset() : void
      {
         send(new GetBundleDiscountRulesetComposer());
      }
      
      public function sendGetProductOffer(param1:int) : void
      {
         send(new GetProductOfferComposer(param1));
      }
      
      private function onBundleDiscountRulesetMessageEvent(param1:BundleDiscountRulesetMessageEvent) : void
      {
         var _loc2_:BundleDiscountRulesetMessageParser = param1.getParser();
         _bundleDiscountRuleset = _loc2_.bundleDiscountRuleset;
         _utils.resolveBundleDiscountFlatPriceSteps();
      }
      
      private function onLimitedEditionSoldOut(param1:LimitedEditionSoldOutEvent) : void
      {
         _windowManager.alert("${catalog.alert.limited_edition_sold_out.title}","${catalog.alert.limited_edition_sold_out.message}",0,alertDialogEventProcessor);
         if(UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 != null)
         {
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1.dispose();
            UnknownVarFromHabboCatalog_PurchaseConfirmationDialog_1 = null;
         }
      }
      
      private function onProductOffer(param1:ProductOfferEvent) : void
      {
         var _loc6_:IFurnitureData = null;
         var _loc3_:ProductOfferMessageParser = param1.getParser();
         var _loc4_:CatalogPageMessageOfferData = _loc3_.offerData;
         if(!_loc4_ || _loc4_.products.length == 0)
         {
            return;
         }
         var _loc5_:CatalogPageMessageProductData = _loc4_.products[0];
         if(UnknownVarFromHabboCatalog_CatalogViewer_1 != null && UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage != null && _loc5_.uniqueLimitedItem)
         {
            UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage.updateLimitedItemsLeft(_loc4_.offerId,_loc5_.uniqueLimitedItemsLeft);
         }
         var _loc7_:Vector.<IProduct> = new Vector.<IProduct>(0);
         var _loc8_:IProductData = getProductData(_loc4_.localizationId);
         for each(_loc5_ in _loc4_.products)
         {
            _loc6_ = getFurnitureData(_loc5_.furniClassId,_loc5_.productType);
            _loc7_.push(new Product(_loc5_.productType,_loc5_.furniClassId,_loc5_.extraParam,getProductCountOverride(_loc4_.localizationId,_loc6_,_loc5_.productCount),_loc8_,_loc6_,this,_loc5_.uniqueLimitedItem,_loc5_.uniqueLimitedItemSeriesSize,_loc5_.uniqueLimitedItemsLeft));
         }
         var _loc2_:Offer = new Offer(_loc4_.offerId,_loc4_.localizationId,_loc4_.isRent,_loc4_.priceInCredits,_loc4_.priceInActivityPoints,_loc4_.activityPointType,_loc4_.priceInSilver,_loc4_.giftable,_loc4_.clubLevel,_loc7_,_loc4_.bundlePurchaseAllowed,this);
         if(!isOfferCompatibleWithCatalogType(_loc2_,_catalogType))
         {
            _loc2_.dispose();
            return;
         }
         if(UnknownVarFromHabboCatalog_CatalogViewer_1 && UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage)
         {
            _loc2_.page = UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage;
            UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage.dispatchWidgetEvent(new SelectProductEvent(_loc2_));
            if(_loc2_.product && _loc2_.product.productType == "i")
            {
               UnknownVarFromHabboCatalog_CatalogViewer_1.currentPage.dispatchWidgetEvent(new SetExtraPurchaseParameterEvent(_loc2_.product.extraParam));
            }
            if(UnknownVarFromHabboCatalog_Boolean_6 && _offerInFurniPlacing)
            {
               _offerInFurniPlacing = _loc2_;
            }
         }
      }
      
      private function onBuildersClubSubscriptionStatus(param1:BuildersClubSubscriptionStatusMessageEvent) : void
      {
         var _loc2_:BuildersClubSubscriptionStatusMessageParser = param1.getParser();
         _builderFurniLimit = _loc2_.furniLimit;
         _builderMaxFurniLimit = _loc2_.maxFurniLimit;
         UnknownVarFromHabboCatalog_Int_1 = _loc2_.secondsLeft;
         _builderMembershipUpdateTime = getTimer();
         UnknownVarFromHabboCatalog_Int_2 = _loc2_.secondsLeftWithGrace;
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.updateBuildersClub",UnknownVarFromHabboCatalog_Int_1 > 0);
         }
         dispatchBuilderSubscriptionUpdatedToCatalogPages();
         refreshBuilderStatus();
      }
      
      private function getProductCountOverride(param1:String, param2:IFurnitureData, param3:int) : int
      {
         if(param1 == "wf_storage_furni_bd" && param2 != null && param2.className == "wf_storage_furni1")
         {
            return 5;
         }
         if(param1 == "wf_storage_coins_bd" && param2 != null && param2.className == "wf_storage_coins2")
         {
            return 5;
         }
         return param3;
      }
      
      private function onBuildersClubFurniCount(param1:BuildersClubFurniCountMessageEvent) : void
      {
         _builderFurniCount = param1.getParser().furniCount;
         dispatchBuilderSubscriptionUpdatedToCatalogPages();
         refreshBuilderStatus();
      }
      
      private function refreshBuilderStatus() : void
      {
         var _loc5_:Number = UnknownVarFromHabboCatalog_Int_1 - (getTimer() - _builderMembershipUpdateTime) / 1000;
         var _loc2_:Number = UnknownVarFromHabboCatalog_Int_2 - (getTimer() - _builderMembershipUpdateTime) / 1000;
         if(UnknownVarFromHabboCatalog_Boolean_15 && _loc5_ <= 0 && _loc2_ > 0)
         {
            events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_IN_GRACE"));
         }
         else if(UnknownVarFromHabboCatalog_Boolean_16 && _loc2_ <= 0)
         {
            events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_EXPIRED"));
         }
         UnknownVarFromHabboCatalog_Boolean_15 = _loc5_ > 0;
         UnknownVarFromHabboCatalog_Boolean_16 = _loc2_ > 0;
         var _loc3_:String = "builder.header.status." + (UnknownVarFromHabboCatalog_Boolean_15 ? "member" : (UnknownVarFromHabboCatalog_Boolean_16 ? "grace" : "trial"));
         var _loc6_:String = _localization.getLocalization(_loc3_);
         _localization.registerParameter("builder.header.title","bcstatus",_loc6_);
         var _loc1_:String = UnknownVarFromHabboCatalog_Boolean_15 ? FriendlyTime.getFriendlyTime(_localization,_loc5_) : (UnknownVarFromHabboCatalog_Boolean_16 ? FriendlyTime.getFriendlyTime(_localization,_loc2_) : _loc6_);
         _localization.registerParameter("builder.header.status.membership","duration","<font color=\"#ff8d00\"><b>" + _loc1_ + "</b></font>");
         _localization.registerParameter("builder.header.status.limit","count","<font color=\"#ff8d00\"><b>" + _builderFurniCount + "</b></font>");
         _localization.registerParameter("builder.header.status.limit","limit","<font color=\"#ff8d00\"><b>" + _builderFurniLimit + "</b></font>");
         _builderMembershipDisplayUpdateTime = getTimer();
         if(_catalogStates != null)
         {
            for each(var _loc4_ in _catalogStates)
            {
               refreshCatalogWindowChrome(_loc4_.catalogType,_loc4_.mainContainer);
            }
         }
      }
      
      public function get bundleDiscountEnabled() : Boolean
      {
         return _catalogType != "BUILDERS_CLUB";
      }
      
      public function get bundleDiscountRuleset() : BundleDiscountRuleset
      {
         return _bundleDiscountRuleset;
      }
      
      public function get multiplePurchaseEnabled() : Boolean
      {
         return getBoolean("catalog.multiple.purchase.enabled") && _catalogType != "BUILDERS_CLUB";
      }
      
      public function get newAdditionsPageOpenDisabled() : Boolean
      {
         return getBoolean("catalog.new.additions.page.open.disabled");
      }
      
      public function showVipBenefits() : void
      {
         if(!_utils)
         {
            init();
         }
         if(_utils)
         {
            if(!getCatalogNavigator("NORMAL").initialized)
            {
               refreshCatalogIndex("NORMAL");
            }
            _utils.showVipBenefits();
         }
      }
      
      public function get currentPage() : ICatalogPage
      {
         return UnknownVarFromHabboCatalog_CatalogViewer_1?.currentPage;
      }
      
      public function displayProductIcon(param1:String, param2:int, param3:IBitmapWrapperController) : void
      {
         _utils.displayProductIcon(param1,param2,param3);
      }
      
      public function openRentConfirmationWindow(param1:IFurnitureData, param2:Boolean, param3:int = -1, param4:int = -1, param5:Boolean = false) : void
      {
         if(UnknownVarFromHabboCatalog_RentConfirmationWindow_1 == null)
         {
            UnknownVarFromHabboCatalog_RentConfirmationWindow_1 = new RentConfirmationWindow(this);
         }
         UnknownVarFromHabboCatalog_RentConfirmationWindow_1.show(param1,param2,param3,param4,param5);
      }
      
      public function get roomSession() : IRoomSession
      {
         return _roomSession;
      }
      
      public function get linkPattern() : String
      {
         return "catalog/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "open":
               if(_loc2_.length > 2)
               {
                  openCatalogPage(_loc2_[2]);
               }
               else
               {
                  openCatalog();
               }
               break;
            case "warehouse":
               if(_loc2_.length > 2)
               {
                  openCatalogPage(_loc2_[2],"BUILDERS_CLUB");
               }
               else
               {
                  toggleCatalog("BUILDERS_CLUB",true);
               }
               break;
            case "club_buy":
               openClubCenter();
               break;
            case "habbicons":
               if(getBoolean("habbicons.enabled"))
               {
                  context.createLinkEvent("habbicons/open");
               }
               break;
            default:
               Logger.log("Catalog unknown link-type receive: " + _loc2_[1]);
         }
      }
      
      public function get inventory() : IHabboInventory
      {
         return _inventory;
      }
      
      public function get mainContainer() : IWindowController_1
      {
         return _mainContainer;
      }
      
      public function toggleBuilderCatalog() : void
      {
         toggleCatalog("BUILDERS_CLUB");
      }
      
      public function get catalogType() : String
      {
         return _catalogType;
      }
      
      public function getCatalogNavigator(param1:String) : ICatalogNavigator
      {
         return _catalogNavigators != null ? _catalogNavigators[param1] : null;
      }
      
      public function get currentCatalogNavigator() : ICatalogNavigator
      {
         return getCatalogNavigator(_catalogType);
      }
      
      public function get builderFurniLimit() : int
      {
         return _builderFurniLimit;
      }
      
      public function get builderFurniCount() : int
      {
         return _builderFurniCount;
      }
      
      public function get builderMaxFurniLimit() : int
      {
         return _builderMaxFurniLimit;
      }
      
      public function get builderSecondsLeft() : Number
      {
         return UnknownVarFromHabboCatalog_Int_1 - (getTimer() - _builderMembershipUpdateTime) / 1000;
      }
      
      public function get builderSecondsLeftWithGrace() : Number
      {
         return UnknownVarFromHabboCatalog_Int_2 - (getTimer() - _builderMembershipUpdateTime) / 1000;
      }
      
      public function getOfferCenter(param1:IOfferExtension) : IOfferCenter
      {
         if(_offerCenter == null)
         {
            _offerCenter = new OfferCenter(windowManager,assets,this);
         }
         _offerCenter.offerExtension = param1;
         return _offerCenter;
      }
      
      public function isNewIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function useNonTabbedCatalog(param1:String) : Boolean
      {
         if(param1 == "BUILDERS_CLUB")
         {
            return true;
         }
         return getBoolean("client.desktop.use.non.tabbed.catalog");
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
   }
}

