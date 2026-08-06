package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.HabboCatalogUtils;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.RenderableShopNftItem;
   import com.sulake.habbo.catalog.collectibles.tabs.MintTokenPurchaseOffer;
   import com.sulake.habbo.catalog.collectibles.tabs.NftStorePurchaseOffer;
   import com.sulake.habbo.catalog.viewer.GameTokensOffer;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.UnknownHabboCatalogViewer1;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.utils.RentUtils;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleBaseItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftStoreOffer;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.window.widgets.IProductImageWidget;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class PurchaseConfirmationDialog implements UnknownIHabboAvatar1, UnknownIHabboRoom1
   {
      private var _catalog:HabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var _localization:IHabboLocalizationManager;
      
      private var UnknownVarFromPurchaseConfirmationDialog_CollectiblesController_1:CollectiblesController;
      
      private var _collectibles:CollectiblesView;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _offerId:int;
      
      private var _productType:String = "";
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_1:int = 0;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_2:int;
      
      private var UnknownVarFromPurchaseConfirmationDialog_String_1:String;
      
      private var UnknownVarFromPurchaseConfirmationDialog_IStuffData_1:IStuffData = null;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Array_1:Array;
      
      private var _userName:String;
      
      private var UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2:IWindowController_1;
      
      private var _highlightIndex:int = -1;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_3:int;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Boolean_1:Boolean = false;
      
      private var _nftProductCode:String;
      
      private const MAX_SUGGESTIONS:int = 10;
      
      private var _receiverName:String = "";
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_4:int;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_5:int = 0;
      
      private var _stuffTypes:Array = [];
      
      private var _ribbonTypes:Array = [];
      
      private var _boxTypes:Array = [];
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_6:int;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_7:int;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_8:int;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Int_9:int;
      
      private var UnknownVarFromPurchaseConfirmationDialog_Timer_1:Timer = null;
      
      private const COLOR_EVEN:uint = 4293848814;
      
      private const COLOR_ODD:uint = 4294967295;
      
      private const COLOR_HIGHLIGHT:uint = 4291613146;
      
      private var _window:IFrameController;
      
      private var _disposed:Boolean = false;
      
      public function PurchaseConfirmationDialog(param1:IHabboLocalizationManager, param2:IAssetLibraryCollection)
      {
         super();
         _localization = param1;
         _assets = param2;
      }
      
      private static function isValentinesBox(param1:int) : Boolean
      {
         return param1 == 8;
      }
      
      public function showOffer(param1:IHabboCatalog, param2:IRoomEngine, param3:UnknownIHabboCatalog1, param4:int, param5:String, param6:int, param7:IStuffData, param8:Array, param9:String, param10:BitmapData) : void
      {
         var _loc11_:NftStorePurchaseOffer = null;
         _catalog = param1 as HabboCatalog;
         _roomEngine = param2;
         _offerId = param3.offerId;
         UnknownVarFromPurchaseConfirmationDialog_Int_2 = param4;
         UnknownVarFromPurchaseConfirmationDialog_String_1 = param5;
         UnknownVarFromPurchaseConfirmationDialog_IStuffData_1 = param7;
         UnknownVarFromPurchaseConfirmationDialog_Array_1 = param8;
         _userName = param9;
         UnknownVarFromPurchaseConfirmationDialog_Int_3 = param6;
         UnknownVarFromPurchaseConfirmationDialog_Boolean_1 = _catalog.bundleDiscountEnabled ? param3.bundlePurchaseAllowed : false;
         if(param3 is Offer && param3.product != null)
         {
            _productType = param3.product.productType;
            UnknownVarFromPurchaseConfirmationDialog_Int_1 = _productType == "habbicon" ? int(param3.product.extraParam) : 0;
         }
         else if(param3 is ClubBuyOfferData || HabboCatalogUtils.buildersClub(param3.localizationId))
         {
            _productType = "h";
         }
         else if(param3 is GameTokensOffer)
         {
            _productType = "GAME_TOKEN";
         }
         else if(param3 is MintTokenPurchaseOffer)
         {
            _productType = "MINT_TOKEN";
         }
         else
         {
            if(!(param3 is NftStorePurchaseOffer))
            {
               return;
            }
            _loc11_ = param3 as NftStorePurchaseOffer;
            _productType = "n";
            _nftProductCode = _loc11_.productCode;
         }
         showConfirmationDialog(param3,param10);
         _catalog.syncPlacedOfferWithPurchase(param3);
      }
      
      private function hideRaffle() : void
      {
         var _loc1_:IWindowModel = _window.findChildByName("raffle_container");
         if(_loc1_ != null && _loc1_.visible)
         {
            _loc1_.visible = false;
            if(UnknownVarFromPurchaseConfirmationDialog_Timer_1 != null)
            {
               _catalog.notifications.addItem("${notification.raffle.ongoing}","ltd");
            }
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hideRaffle();
         _disposed = true;
         _catalog = null;
         _roomEngine = null;
         _offerId = -1;
         UnknownVarFromPurchaseConfirmationDialog_Int_1 = 0;
         UnknownVarFromPurchaseConfirmationDialog_Int_2 = -1;
         UnknownVarFromPurchaseConfirmationDialog_String_1 = "";
         UnknownVarFromPurchaseConfirmationDialog_Array_1 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromPurchaseConfirmationDialog_Timer_1 != null && UnknownVarFromPurchaseConfirmationDialog_Timer_1.running)
         {
            UnknownVarFromPurchaseConfirmationDialog_Timer_1.stop();
         }
         UnknownVarFromPurchaseConfirmationDialog_Timer_1 = null;
         UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 = null;
         if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2 != null)
         {
            UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2.dispose();
            UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get productType() : String
      {
         return _productType;
      }
      
      public function getIconWrapper() : IBitmapWrapperController
      {
         return !!_window ? _window.findChildByName("product_image") as IBitmapWrapperController : null;
      }
      
      public function getNftImage() : IProductImageWidget
      {
         var _loc1_:IWidgetWindowController = _window.findChildByName("nft_image") as IWidgetWindowController;
         return _loc1_.widget as IProductImageWidget;
      }
      
      public function isGiftPurchase() : Boolean
      {
         return _receiverName != null && _receiverName != "";
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == UnknownVarFromPurchaseConfirmationDialog_Int_4)
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_4 = 0;
            setImage(param2,true);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setImage(param1:BitmapData, param2:Boolean) : void
      {
         if(_window == null || param1 == null || disposed)
         {
            return;
         }
         var _loc5_:IBitmapWrapperController = getIconWrapper();
         if(_loc5_ == null)
         {
            return;
         }
         if(_loc5_.bitmap != null)
         {
            _loc5_.bitmap.dispose();
            _loc5_.bitmap = null;
         }
         if(_loc5_.bitmap == null)
         {
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         }
         var _loc3_:int = (_loc5_.width - param1.width) * 0.5;
         var _loc4_:int = (_loc5_.height - param1.height) * 0.5;
         _loc5_.bitmap.draw(param1,new Matrix(1,0,0,1,_loc3_,_loc4_));
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function showConfirmationDialog(param1:UnknownIHabboCatalog1, param2:BitmapData) : void
      {
         var _loc20_:IProductData = null;
         var _loc21_:IItemListWindow = null;
         var _loc8_:int = 0;
         var _loc15_:NftStorePurchaseOffer = null;
         var _loc10_:CollectibleBaseItem = null;
         var _loc11_:Boolean = false;
         var _loc17_:String = null;
         var _loc22_:BitmapDataAsset = null;
         var _loc19_:IRoomEngine = null;
         var _loc6_:UnknownHabboRoom1 = null;
         var _loc13_:* = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc3_:IProduct = null;
         var _loc12_:IAvatarImage_2 = null;
         if(_catalog == null)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         _window = _catalog.utils.createWindow("purchase_confirmation",2) as IFrameController;
         if(_window == null)
         {
            return;
         }
         updateLocalizations(param1);
         var _loc18_:IWindowController_1 = _window.findChildByName("purchase_cost_box") as IWindowController_1;
         _catalog.utils.showPriceInContainer(_loc18_,param1,UnknownVarFromPurchaseConfirmationDialog_Int_3);
         addClickListener("buy_button",onBuyButtonClick);
         addClickListener("cancel_button",onClose);
         addClickListener("header_button_close",onClose);
         hideRaffle();
         _window.center();
         if(_catalog.getBoolean("disclaimer.credit_spending.enabled"))
         {
            _window.findChildByName("spending_disclaimer").addEventListener("WME_CLICK",onSpendingDisclaimerClicked);
            _window.findChildByName("spending_disclaimer").addEventListener("WME_DOUBLE_CLICK",onSpendingDisclaimerClicked);
            setDisclaimerAccepted(false);
         }
         else
         {
            _window.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         var _loc14_:ITextWindow = _window.findChildByName("product_name") as ITextWindow;
         if(_loc14_ != null)
         {
            _loc20_ = _catalog.getProductData(param1.localizationId);
            _loc14_.text = _loc20_?.name;
         }
         var _loc4_:ITextWindow = _window.findChildByName("quantity") as ITextWindow;
         if(_loc4_ != null)
         {
            if(_catalog.multiplePurchaseEnabled && UnknownVarFromPurchaseConfirmationDialog_Int_3 > 1)
            {
               _loc4_.text = "X " + UnknownVarFromPurchaseConfirmationDialog_Int_3;
            }
            else
            {
               _loc21_ = IItemListWindow(_window.findChildByName("properties_itemlist"));
               if(_loc21_ != null)
               {
                  _loc21_.removeListItem(_loc4_);
               }
            }
         }
         _window.findChildByName("freeQuantity").visible = false;
         if(_catalog.bundleDiscountEnabled)
         {
            _loc8_ = _catalog.utils.getDiscountItemsCount(UnknownVarFromPurchaseConfirmationDialog_Int_3);
            _window.findChildByName("freeQuantity").visible = _loc8_ > 0;
            _catalog.localization.registerParameter("shop.bonus.items.count","amount",_loc8_.toString());
         }
         var _loc16_:IWidgetWindowController = _window.findChildByName("nft_image") as IWidgetWindowController;
         var _loc23_:IProductImageWidget = _loc16_.widget as IProductImageWidget;
         if(param1 is NftStorePurchaseOffer)
         {
            _loc15_ = param1 as NftStorePurchaseOffer;
            _loc10_ = _loc15_.productInfo;
            _loc23_.productInfo = new RenderableShopNftItem(_loc10_);
            return;
         }
         _loc16_.visible = false;
         _loc23_.clearPreviewer();
         var _loc9_:IBitmapWrapperController = getIconWrapper();
         if(_loc9_ != null)
         {
            _loc11_ = false;
            if(UnknownHabboCatalogViewer1.hasProductImage(param1.localizationId))
            {
               _loc17_ = UnknownHabboCatalogViewer1.PRODUCT_IMAGES[param1.localizationId];
               _loc22_ = _assets.getAssetByName(_loc17_) as BitmapDataAsset;
               if(_loc22_)
               {
                  setImage(_loc22_.content as BitmapData,false);
                  _loc11_ = true;
               }
            }
            if(!_loc11_ && (param1.product || param1 is MintTokenPurchaseOffer))
            {
               _loc19_ = _catalog.roomEngine;
               _loc5_ = 0;
               _loc7_ = "";
               if(param1 is Offer)
               {
                  _loc3_ = param1.product;
                  if(_loc3_ != null)
                  {
                     _loc5_ = _loc3_.productClassId;
                     _loc7_ = _loc3_.extraParam;
                  }
               }
               if(param2 == null)
               {
                  switch(productType)
                  {
                     case "s":
                        _loc6_ = _loc19_.getFurnitureImage(_loc5_,new Vector3d(90,0,0),64,this,0,_loc7_,-1,-1,UnknownVarFromPurchaseConfirmationDialog_IStuffData_1);
                        break;
                     case "i":
                        _loc6_ = _loc19_.getWallItemImage(_loc5_,new Vector3d(90,0,0),64,this,0,_loc7_);
                        break;
                     case "e":
                        _loc13_ = _catalog.getPixelEffectIcon(_loc5_);
                        break;
                     case "h":
                        _loc13_ = _catalog.getSubscriptionProductIcon(_loc5_);
                        break;
                     case "MINT_TOKEN":
                        _loc13_ = _catalog.getMintTokenProductIcon();
                        break;
                     case "chat_style":
                        _loc13_ = _catalog.freeFlowChat.chatStyleLibrary.getStyle(int(_loc3_.extraParam)).selectorPreview.clone();
                        break;
                     case "r":
                        _loc12_ = _catalog.avatarRenderManager.createAvatarImage(_loc7_,"h",null,this);
                        _loc12_.setDirection("full",3);
                        _loc12_.appendAction("wave");
                        _loc12_.appendAction("gest","sml");
                        _loc13_ = _loc12_.getImage("full",true);
                        _loc12_.dispose();
                        break;
                     case "habbicon":
                        _loc13_ = getHabbiconPreviewBitmap(_loc7_);
                        if(_loc13_ == null)
                        {
                           _loc13_ = new BitmapData(40,40,false,9408399);
                        }
                  }
                  if(_loc6_ != null)
                  {
                     _loc13_ = _loc6_.data;
                     UnknownVarFromPurchaseConfirmationDialog_Int_4 = _loc6_.id;
                  }
               }
               else
               {
                  _loc13_ = param2;
               }
               setImage(_loc13_,true);
               RentUtils.updateBuyCaption(param1,_window.findChildByName("buy_button") as UnknownICoreWindowComponents4);
            }
         }
      }
      
      private function showNftConfirmationDialog(param1:NftStoreOffer) : void
      {
      }
      
      private function onSpendingDisclaimerClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:UnknownICoreWindowComponents2 = param1.target as UnknownICoreWindowComponents2;
         if(_loc2_ != null)
         {
            setDisclaimerAccepted(_loc2_.isSelected);
         }
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("buy_button");
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      private function updateLocalizations(param1:UnknownIHabboCatalog1) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IProductData = _catalog.getProductData(param1.localizationId);
         var _loc3_:String = _loc2_?.name;
         _catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.costs","offer_name",_loc3_);
      }
      
      private function addClickListener(param1:String, param2:Function) : void
      {
         var _loc3_:IWindowModel = _window.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",param2);
         }
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         if(_catalog == null || _catalog.avatarRenderManager == null)
         {
            return null;
         }
         var _loc2_:BitmapData = null;
         var _loc3_:IAvatarImage_2 = _catalog.avatarRenderManager.createAvatarImage(param1,"h",null,this);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getCroppedImage("head");
            _loc3_.dispose();
         }
         return _loc2_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_catalog == null || _window == null || Boolean(_window.disposed) || disposed)
         {
            return;
         }
         if(param1 == _catalog.sessionDataManager.figure)
         {
            updateGiftDialogAvatarImage();
         }
         var _loc2_:IAvatarImage_2 = _catalog.avatarRenderManager.createAvatarImage(param1,"h",null,this);
         _loc2_.setDirection("full",3);
         _loc2_.appendAction("wave");
         _loc2_.appendAction("gest","sml");
         var _loc3_:BitmapData = _loc2_.getImage("full",true);
         _loc2_.dispose();
         setImage(_loc3_,true);
      }
      
      private function getHabbiconPreviewBitmap(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(int(param1),false);
         return _loc2_ != null ? _loc2_.clone() : null;
      }
      
      private function enableGiftDialogAvatarImage(param1:Boolean) : void
      {
         var _loc2_:IBitmapWrapperController = _window.findChildByName("avatar_image") as IBitmapWrapperController;
         if(_loc2_ != null)
         {
            if(param1)
            {
               updateGiftDialogAvatarImage();
            }
            else
            {
               updateUnknownSenderAvatarImage();
            }
         }
         var _loc3_:ITextWindow = _window.findChildByName("message_from") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.visible = param1;
         }
      }
      
      private function updateGiftDialogAvatarImage() : void
      {
         var _loc1_:BitmapData = getAvatarFaceBitmap(_catalog.sessionDataManager.figure);
         if(_loc1_ != null)
         {
            updateAvatarImage(_loc1_);
         }
      }
      
      private function updateUnknownSenderAvatarImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapDataAsset = _assets.getAssetByName("gift_incognito") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.content as BitmapData;
            if(_loc1_ != null)
            {
               updateAvatarImage(_loc1_.clone());
            }
         }
      }
      
      private function updateAvatarImage(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = _window.findChildByName("avatar_image") as IBitmapWrapperController;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.bitmap = param1;
         _loc2_.width = param1.width;
         _loc2_.height = param1.height;
      }
      
      private function onShowFaceSelected(param1:WindowEvent) : void
      {
         enableGiftDialogAvatarImage(true);
         updateGiftDialogAvatarImage();
      }
      
      private function onShowFaceUnselected(param1:WindowEvent) : void
      {
         enableGiftDialogAvatarImage(false);
      }
      
      private function isShowPurchaserName() : Boolean
      {
         var _loc1_:UnknownICoreWindowComponents2 = null;
         if(isModerator())
         {
            if(_window != null)
            {
               _loc1_ = _window.findChildByName("show_face_checkbox") as UnknownICoreWindowComponents2;
               if(_loc1_ != null)
               {
                  return _loc1_.isSelected;
               }
            }
            return false;
         }
         return true;
      }
      
      private function updateGiftDialogLabels() : void
      {
         var _loc9_:IWindowModel = null;
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = isDefaultBoxSelected();
         var _loc6_:* = "";
         var _loc7_:String = "";
         var _loc1_:ILocalization = null;
         var _loc2_:ITextWindow = _window.findChildByName("pick_box_title") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc7_ = _loc3_ ? "catalog.gift_wrapping_new.box.default" : "catalog.gift_wrapping_new.box." + _boxTypes[UnknownVarFromPurchaseConfirmationDialog_Int_7];
            _loc1_ = _localization.getLocalizationRaw(_loc7_);
            _loc6_ = _loc7_;
            if(_loc1_ != null)
            {
               _loc6_ = _loc1_.value;
            }
            _loc2_.text = _loc6_;
         }
         var _loc5_:ITextWindow = _window.findChildByName("pick_box_price_title") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc7_ = _loc3_ ? "catalog.gift_wrapping_new.freeprice" : "catalog.gift_wrapping_new.price";
            _loc1_ = _localization.getLocalizationRaw(_loc7_);
            _loc6_ = _loc7_;
            if(_loc1_ != null)
            {
               _loc6_ = _loc1_.value;
            }
            _loc5_.text = _loc6_;
         }
         var _loc8_:IItemListWindow = _window.findChildByName("price_box_container") as IItemListWindow;
         if(_loc8_ != null)
         {
            _loc9_ = _loc8_.getListItemByName("small_coin");
            if(_loc9_ != null)
            {
               _loc9_.visible = !_loc3_;
               _loc8_.arrangeListItems();
            }
         }
         var _loc4_:ITextWindow = _window.findChildByName("pick_ribbon_title") as ITextWindow;
         if(_loc4_ != null)
         {
            _loc7_ = "catalog.gift_wrapping_new.ribbon." + UnknownVarFromPurchaseConfirmationDialog_Int_6;
            _loc1_ = _localization.getLocalizationRaw(_loc7_);
            _loc6_ = _loc7_;
            if(_loc1_ != null)
            {
               _loc6_ = _loc1_.value;
            }
            _loc4_.text = _loc6_;
         }
      }
      
      public function showGiftDialog() : void
      {
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc11_:String = null;
         var _loc3_:Number = NaN;
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc7_:GiftWrappingConfiguration = _catalog.giftWrappingConfiguration;
         _window = _catalog.utils.createWindow("gift_wrapping") as IFrameController;
         if(_window == null)
         {
            return;
         }
         _window.center();
         addClickListener("give_gift_button",onGiveGiftButtonClick);
         addClickListener("cancel_link_region",onCancelGift);
         addClickListener("header_button_close",onCancelGift);
         var _loc8_:IWindowModel = _window.findChildByName("name_input");
         if(_loc8_ != null)
         {
            if(_userName != null)
            {
               setReceiverName(_userName);
            }
            else
            {
               focusNameField();
            }
            updateNameHint();
            _loc8_.addEventListener("WE_CHANGE",onNameInputChange);
            _loc8_.addEventListener("WME_DOWN",onNameInputMouseDown);
            _loc8_.addEventListener("WKE_KEY_UP",onNameInputKeyUp);
            _loc8_.addEventListener("WE_FOCUSED",onNameInputFocus);
            _loc8_.addEventListener("WE_UNFOCUSED",onNameInputUnfocus);
         }
         var _loc9_:IStaticBitmapWrapperWindow = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow;
         if(_loc9_)
         {
            _loc4_ = _catalog.getProperty("catalog.gift_wrapping_new.gift_card");
            if(_loc4_ != "")
            {
               _loc9_.assetUri = "${image.library.url}Giftcards/" + _loc4_ + ".png";
            }
         }
         var _loc2_:UnknownICoreWindowComponents2 = _window.findChildByName("show_face_checkbox") as UnknownICoreWindowComponents2;
         if(_loc2_)
         {
            if(isModerator())
            {
               _loc2_.visible = true;
               _loc2_.select();
               _loc2_.addEventListener("WE_SELECT",onShowFaceSelected);
               _loc2_.addEventListener("WE_UNSELECT",onShowFaceUnselected);
            }
            else
            {
               _loc2_.visible = false;
            }
         }
         var _loc1_:IWindowModel = _window.findChildByName("show_face_checkbox_title");
         if(_loc1_ != null && !isModerator())
         {
            _loc1_.visible = false;
         }
         updateGiftDialogAvatarImage();
         var _loc5_:IWindowModel = _window.findChildByName("message_input");
         if(_loc5_ != null)
         {
            updateMessageHint();
            _loc5_.addEventListener("WE_CHANGE",onMessageInputChange);
            _loc5_.addEventListener("WE_FOCUSED",onMessageInputFocus);
            _loc5_.addEventListener("WE_UNFOCUSED",onMessageInputUnfocus);
         }
         var _loc10_:IWindowModel = _window.findChildByName("message_from");
         if(_loc10_ != null)
         {
            _loc6_ = _catalog.sessionDataManager.userName;
            _loc11_ = "catalog.gift_wrapping_new.message_from";
            _localization.registerParameter(_loc11_,"name",_loc6_);
            _loc10_.caption = _localization.getLocalization(_loc11_,_loc6_);
         }
         addClickListener("ribbon_prev",onPreviousGiftWrap);
         addClickListener("ribbon_next",onNextGiftWrap);
         addClickListener("box_prev",onPreviousGiftBox);
         addClickListener("box_next",onNextGiftBox);
         _localization.registerParameter("catalog.gift_wrapping_new.price","price",_loc7_.price.toString());
         if(_loc7_.defaultStuffTypes.length > 0)
         {
            _loc3_ = Math.floor(Math.random() * _loc7_.defaultStuffTypes.length);
            UnknownVarFromPurchaseConfirmationDialog_Int_5 = _loc7_.defaultStuffTypes[_loc3_];
         }
         _stuffTypes = _loc7_.stuffTypes;
         _boxTypes = _boxTypes.concat(_loc7_.boxTypes);
         _boxTypes.push(UnknownVarFromPurchaseConfirmationDialog_Int_5);
         _ribbonTypes = _loc7_.ribbonTypes;
         UnknownVarFromPurchaseConfirmationDialog_Int_8 = _stuffTypes[0];
         UnknownVarFromPurchaseConfirmationDialog_Int_6 = _ribbonTypes[0];
         UnknownVarFromPurchaseConfirmationDialog_Int_7 = _catalog.getInteger("catalog.purchase.gift_wrapping.default_box_index",0);
         if(UnknownVarFromPurchaseConfirmationDialog_Int_7 < 0 || UnknownVarFromPurchaseConfirmationDialog_Int_7 > _boxTypes.length - 1)
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_7 = 0;
         }
         initColorGrid();
         updateColorGrid();
         updatePreview();
      }
      
      private function isModerator() : Boolean
      {
         return _catalog.sessionDataManager.hasSecurity(5);
      }
      
      private function isDefaultBoxSelected() : Boolean
      {
         return _boxTypes[UnknownVarFromPurchaseConfirmationDialog_Int_7] == UnknownVarFromPurchaseConfirmationDialog_Int_5;
      }
      
      private function updatePreview() : void
      {
         if(UnknownVarFromPurchaseConfirmationDialog_Int_6 < 0)
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_6 = _ribbonTypes.length - 1;
         }
         if(UnknownVarFromPurchaseConfirmationDialog_Int_6 > _ribbonTypes.length - 1)
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_6 = 0;
         }
         if(UnknownVarFromPurchaseConfirmationDialog_Int_7 < 0)
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_7 = _boxTypes.length - 1;
         }
         if(UnknownVarFromPurchaseConfirmationDialog_Int_7 > _boxTypes.length - 1)
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_7 = 0;
         }
         var _loc5_:int = int(_boxTypes[UnknownVarFromPurchaseConfirmationDialog_Int_7]);
         if(isValentinesBox(_loc5_))
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_6 = 10;
            if(UnknownVarFromPurchaseConfirmationDialog_Int_6 > _ribbonTypes.length - 1)
            {
               UnknownVarFromPurchaseConfirmationDialog_Int_6 = 0;
            }
         }
         var _loc2_:int = _loc5_ * 1000 + _ribbonTypes[UnknownVarFromPurchaseConfirmationDialog_Int_6];
         if(_window == null)
         {
            return;
         }
         if(_roomEngine == null)
         {
            return;
         }
         var _loc3_:String = _loc2_.toString();
         var _loc6_:int = UnknownVarFromPurchaseConfirmationDialog_Int_8;
         var _loc1_:Boolean = isDefaultBoxSelected();
         if(_loc1_)
         {
            enableBoxColorAndRibbonSelectors(false);
            _loc6_ = UnknownVarFromPurchaseConfirmationDialog_Int_5;
            _loc3_ = "";
         }
         else if(isValentinesBox(_loc5_))
         {
            enableBoxColorAndRibbonSelectors(false);
         }
         else
         {
            enableBoxColorAndRibbonSelectors(true);
            if(_loc5_ >= 3 && _loc5_ <= 6)
            {
               enableBoxColorSelectors(false);
            }
         }
         var _loc4_:UnknownHabboRoom1 = _roomEngine.getFurnitureImage(_loc6_,new Vector3d(180),64,this,0,_loc3_);
         if(_loc4_ == null)
         {
            return;
         }
         UnknownVarFromPurchaseConfirmationDialog_Int_4 = _loc4_.id;
         setImage(_loc4_.data,true);
         showSuggestions(false);
         updateGiftDialogLabels();
      }
      
      private function initColorGrid() : void
      {
         var _loc3_:IFurnitureData = null;
         var _loc2_:IWindowController_1 = null;
         if(_window == null)
         {
            return;
         }
         var _loc1_:IItemGridWindow = _window.findChildByName("color_grid") as IItemGridWindow;
         _loc1_.destroyGridItems();
         var _loc5_:IWindowController_1 = _catalog.utils.createWindow("gift_palette_item") as IWindowController_1;
         for each(var _loc4_ in _stuffTypes)
         {
            _loc3_ = _catalog.getFurnitureData(_loc4_,"s");
            _loc2_ = _loc5_.clone() as IWindowController_1;
            if(!(!_loc3_ || !_loc2_))
            {
               _loc2_.addEventListener("WME_CLICK",onColorItemClick);
               _loc2_.findChildByName("color").color = _loc3_.colours[0];
               _loc2_.id = _loc4_;
               _loc1_.addGridItem(_loc2_);
            }
         }
      }
      
      private function giveGift() : void
      {
         var _loc3_:IWindowModel = _window.findChildByName("name_input");
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:String = _loc3_.caption;
         var _loc1_:IWindowModel = _window.findChildByName("message_input");
         var _loc8_:String = _loc1_?.caption;
         var _loc9_:Boolean = isDefaultBoxSelected();
         var _loc7_:int = _loc9_ ? UnknownVarFromPurchaseConfirmationDialog_Int_5 : UnknownVarFromPurchaseConfirmationDialog_Int_8;
         var _loc5_:int = int(_loc9_ ? 0 : _boxTypes[UnknownVarFromPurchaseConfirmationDialog_Int_7]);
         var _loc6_:int = int(_loc9_ ? 0 : _ribbonTypes[UnknownVarFromPurchaseConfirmationDialog_Int_6]);
         var _loc2_:Boolean = isShowPurchaserName();
         _catalog.purchaseProductAsGift(UnknownVarFromPurchaseConfirmationDialog_Int_2,_offerId,UnknownVarFromPurchaseConfirmationDialog_String_1,_loc4_,_loc8_,_loc7_,_loc5_,_loc6_,_loc2_);
      }
      
      private function safeDisable(param1:String) : void
      {
         var _loc2_:IWindowModel = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.disable();
         }
      }
      
      private function safeEnable(param1:String) : void
      {
         var _loc2_:IWindowModel = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.enable();
         }
      }
      
      private function onBuyButtonClick(param1:WindowEvent) : void
      {
         var _loc2_:ICatalogPage = null;
         if(_productType == "habbicon" && !_catalog.getBoolean("habbicons.enabled"))
         {
            return;
         }
         if(_productType == "habbicon" && _catalog.isHabbiconOwned(UnknownVarFromPurchaseConfirmationDialog_Int_1))
         {
            _catalog.showHabbiconAlreadyOwnedAlert();
            return;
         }
         safeDisable("buy_button");
         safeDisable("cancel_button");
         safeDisable("publish_check");
         if(_productType == "GAME_TOKEN")
         {
            _catalog.purchaseGameTokensOffer(UnknownVarFromPurchaseConfirmationDialog_String_1);
         }
         else if(_productType == "MINT_TOKEN")
         {
            _catalog.purchaseMintTokens(_offerId,UnknownVarFromPurchaseConfirmationDialog_String_1);
         }
         else if(_productType == "n")
         {
            _catalog.purchaseNftOffer(_nftProductCode,UnknownVarFromPurchaseConfirmationDialog_String_1);
         }
         else
         {
            _catalog.purchaseProduct(UnknownVarFromPurchaseConfirmationDialog_Int_2,_offerId,UnknownVarFromPurchaseConfirmationDialog_String_1,UnknownVarFromPurchaseConfirmationDialog_Int_3);
            _loc2_ = _catalog.currentPage;
            if(_loc2_ != null)
            {
               _loc2_.dispatchWidgetEvent(new CatalogWidgetEvent("PURCHASE"));
            }
         }
      }
      
      private function onGiftButtonClick(param1:WindowEvent) : void
      {
         showGiftDialog();
         HabboTracking.getInstance().trackEventLog("Catalog","clickConfirm","client.buy_as_gift.clicked");
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         _catalog.resetPlacedOfferData();
         dispose();
      }
      
      private function onGiveGiftButtonClick(param1:WindowEvent) : void
      {
         giveGift();
         enableGiftButton(false);
         _catalog.giftReceiver = null;
         _catalog.resetPlacedOfferData();
      }
      
      private function onCancelGift(param1:WindowEvent) : void
      {
         _catalog.resetPlacedOfferData();
         dispose();
      }
      
      private function onPreviousGiftWrap(param1:WindowEvent) : void
      {
         UnknownVarFromPurchaseConfirmationDialog_Int_6--;
         updatePreview();
      }
      
      private function onNextGiftWrap(param1:WindowEvent) : void
      {
         UnknownVarFromPurchaseConfirmationDialog_Int_6++;
         updatePreview();
      }
      
      private function onPreviousGiftBox(param1:WindowEvent) : void
      {
         UnknownVarFromPurchaseConfirmationDialog_Int_7--;
         updatePreview();
      }
      
      private function onNextGiftBox(param1:WindowEvent) : void
      {
         UnknownVarFromPurchaseConfirmationDialog_Int_7++;
         updatePreview();
      }
      
      private function onNameInputChange(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateNameHint();
         if(_receiverName == _loc2_.caption)
         {
            return;
         }
         var _loc3_:String = _loc2_.caption.toLowerCase();
         var _loc5_:Array = [];
         for each(var _loc4_ in UnknownVarFromPurchaseConfirmationDialog_Array_1)
         {
            if(_loc4_.toLowerCase().search(_loc3_) != -1)
            {
               _loc5_.push(_loc4_);
            }
            if(_loc5_.length >= 10)
            {
               break;
            }
         }
         _receiverName = _loc2_.caption;
         updateSuggestions(_loc5_);
      }
      
      private function onNameInputMouseDown(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         showSuggestions(false);
      }
      
      private function onNameInputKeyUp(param1:WindowEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         var _loc2_:IWindowModel = param1.target;
         switch(_loc4_.keyCode)
         {
            case 38:
               highlightSuggestion(_highlightIndex - 1);
               break;
            case 40:
               highlightSuggestion(_highlightIndex + 1);
               if(_loc2_ != null)
               {
                  if(_loc2_.caption.length == 0)
                  {
                     if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 == null || !UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1.visible)
                     {
                        _loc3_ = showAllFriendSuggestions();
                        if(_loc3_)
                        {
                           highlightSuggestion(0);
                        }
                     }
                  }
               }
               break;
            case 13:
               selectHighlighted();
               break;
            case 9:
               focusMessageField();
         }
      }
      
      private function showAllFriendSuggestions() : Boolean
      {
         var _loc2_:Array = null;
         if(UnknownVarFromPurchaseConfirmationDialog_Array_1 != null && UnknownVarFromPurchaseConfirmationDialog_Array_1.length > 0)
         {
            _loc2_ = [];
            for each(var _loc1_ in UnknownVarFromPurchaseConfirmationDialog_Array_1)
            {
               _loc2_.push(_loc1_);
               if(_loc2_.length >= 10)
               {
                  break;
               }
            }
            updateSuggestions(_loc2_);
            showSuggestions(true);
            return true;
         }
         return false;
      }
      
      private function focusNameField() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = _window.findChildByName("name_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = true;
         _loc1_.focus();
      }
      
      private function focusMessageField() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = _window.findChildByName("message_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = true;
         _loc1_.focus();
      }
      
      private function selectHighlighted() : void
      {
         if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 == null || !UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1.visible)
         {
            return;
         }
         var _loc3_:IItemListWindow = UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1.findChildByName("suggestion_list") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:IWindowController_1 = _loc3_.getListItemAt(_highlightIndex) as IWindowController_1;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:IWindowModel = _loc1_.findChildByName("name_text");
         if(_loc2_ == null)
         {
            return;
         }
         setReceiverName(_loc2_.caption);
         showSuggestions(false);
      }
      
      private function showSuggestions(param1:Boolean) : void
      {
         if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 == null)
         {
            return;
         }
         UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1.visible = param1;
         if(!param1)
         {
            showMessageInput(true);
         }
      }
      
      private function showMessageInput(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = _window.findChildByName("message_input");
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      private function onMessageInputChange(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateMessageHint();
      }
      
      private function onNameInputFocus(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateNameHint();
      }
      
      private function onNameInputUnfocus(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateNameHint();
      }
      
      private function onMessageInputFocus(param1:WindowEvent) : void
      {
         updateMessageHint();
         showSuggestions(false);
      }
      
      private function onMessageInputUnfocus(param1:WindowEvent) : void
      {
         updateMessageHint();
      }
      
      private function updateNameHint() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:IWindowModel = _window.findChildByName("name_input");
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:String = _loc1_.caption;
         if(_loc2_ == null || _loc2_.length == 0)
         {
            enableHint(true,"name_input_hint","catalog.gift_wrapping_new.name_hint");
         }
         else
         {
            enableHint(false,"name_input_hint","catalog.gift_wrapping_new.name_hint");
         }
      }
      
      private function updateMessageHint() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:IWindowModel = _window.findChildByName("message_input");
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:String = _loc1_.caption;
         if(_loc2_ == null || _loc2_.length == 0)
         {
            enableHint(true,"message_input_hint","catalog.gift_wrapping_new.message_hint");
         }
         else
         {
            enableHint(false,"message_input_hint","catalog.gift_wrapping_new.message_hint");
         }
      }
      
      private function enableHint(param1:Boolean, param2:String, param3:String) : void
      {
         var _loc4_:ITextWindow = _window.findChildByName(param2) as ITextWindow;
         if(_loc4_ != null)
         {
            _loc4_.text = _localization.getLocalization(param3);
            _loc4_.visible = param1;
         }
      }
      
      private function enableRibbonSelectors(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("ribbon_prev");
         enableWindow(_loc2_,param1);
         var _loc3_:IWindowModel = _window.findChildByName("ribbon_next");
         enableWindow(_loc3_,param1);
         var _loc4_:IWindowModel = _window.findChildByName("pick_ribbon_title");
         enableWindow(_loc4_,param1);
      }
      
      private function enableBoxColorAndRibbonSelectors(param1:Boolean) : void
      {
         enableBoxColorSelectors(param1);
         enableRibbonSelectors(param1);
      }
      
      private function enableBoxColorSelectors(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IWindowModel = _window.findChildByName("box_color_title");
         enableWindow(_loc3_,param1);
         var _loc2_:IWindowController_1 = _window.findChildByName("color_picker_container") as IWindowController_1;
         if(_loc2_ != null)
         {
            enableWindow(_loc2_,param1);
         }
      }
      
      private function enableWindow(param1:IWindowModel, param2:Boolean) : void
      {
         var _loc3_:IIterator = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:IWindowModel = null;
         enableElement(param1,param2);
         if(param1 is IIterable)
         {
            _loc3_ = IIterable(param1).iterator;
            _loc4_ = int(_loc3_.length);
            if(_loc4_ > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = _loc3_[_loc5_] as IWindowModel;
                  if(_loc6_ != null)
                  {
                     enableElement(_loc6_,param2);
                     if(_loc6_ is IIterable)
                     {
                        enableWindow(_loc6_,param2);
                     }
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      private function enableElement(param1:IWindowModel, param2:Boolean) : void
      {
         if(param2)
         {
            param1.blend = 1;
            param1.enable();
         }
         else
         {
            param1.blend = 0.5;
            param1.disable();
         }
      }
      
      private function updateSuggestions(param1:Array) : void
      {
         var _loc5_:IWindowController_1 = null;
         var _loc7_:ITextWindow = null;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:TextFormat = null;
         var _loc3_:int = 0;
         if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 == null)
         {
            UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 = _window.findChildByName("suggestion_container") as IWindowController_1;
         }
         if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2 == null)
         {
            UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2 = _catalog.utils.createWindow("suggestion_list_item_new") as IWindowController_1;
         }
         if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 == null || UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2 == null)
         {
            return;
         }
         var _loc9_:IItemListWindow = UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1.findChildByName("suggestion_list") as IItemListWindow;
         if(_loc9_ == null)
         {
            return;
         }
         _loc9_.removeListItems();
         if(param1.length == 0)
         {
            showSuggestions(false);
            return;
         }
         showSuggestions(true);
         var _loc6_:int = 0;
         for each(var _loc4_ in param1)
         {
            _loc5_ = UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_2.clone() as IWindowController_1;
            if(_loc5_ != null)
            {
               _loc5_.addEventListener("WME_CLICK",onSuggestionsClick);
               _loc5_.addEventListener("WME_OVER",onSuggestionsMouseOver);
               _loc7_ = _loc5_.findChildByName("name_text") as ITextWindow;
               if(_loc7_ != null)
               {
                  _loc7_.text = _loc4_;
                  if(_receiverName != null)
                  {
                     _loc2_ = _receiverName.length;
                     if(_loc2_ > 0)
                     {
                        _loc8_ = int(_loc4_.toLowerCase().search(_receiverName.toLowerCase()));
                        if(_loc8_ != -1)
                        {
                           _loc10_ = _loc7_.getTextFormat();
                           _loc10_.bold = true;
                           _loc3_ = _loc8_ + _loc2_;
                           if(_loc3_ > _loc4_.length)
                           {
                              _loc3_ = _loc4_.length;
                           }
                           _loc7_.setTextFormat(_loc10_,_loc8_,_loc3_);
                        }
                     }
                  }
                  _loc9_.addListItem(_loc5_);
               }
               _loc5_.color = getColor(_loc6_);
               _loc6_++;
            }
         }
         showMessageInput(param1.length < 2);
         highlightSuggestion(0);
      }
      
      private function onSuggestionsClick(param1:WindowEvent) : void
      {
         var _loc2_:IWindowController_1 = param1.target as IWindowController_1;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.findChildByName("name_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         setReceiverName(_loc3_.text);
         showSuggestions(false);
      }
      
      private function onSuggestionsMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:IWindowController_1 = param1.target as IWindowController_1;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1.findChildByName("suggestion_list") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         highlightSuggestion(_loc3_.getListItemIndex(_loc2_));
      }
      
      private function highlightSuggestion(param1:int) : void
      {
         var _loc2_:IWindowController_1 = null;
         if(UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = UnknownVarFromPurchaseConfirmationDialog_IWindowController_1_1.findChildByName("suggestion_list") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_ = _loc3_.getListItemAt(_highlightIndex) as IWindowController_1;
         if(_loc2_ != null)
         {
            _loc2_.color = getColor(_highlightIndex);
         }
         _highlightIndex = param1;
         if(_highlightIndex < 0)
         {
            _highlightIndex = _loc3_.numListItems - 1;
         }
         if(_highlightIndex >= _loc3_.numListItems)
         {
            _highlightIndex = 0;
         }
         _loc2_ = _loc3_.getListItemAt(_highlightIndex) as IWindowController_1;
         if(_loc2_ != null)
         {
            _loc2_.color = 4291613146;
         }
      }
      
      private function getColor(param1:int) : uint
      {
         return param1 % 2 == 0 ? 4293848814 : 4294967295;
      }
      
      private function setReceiverName(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("name_input");
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.caption = param1;
         updateNameHint();
         focusMessageField();
      }
      
      private function onColorItemClick(param1:WindowEvent) : void
      {
         UnknownVarFromPurchaseConfirmationDialog_Int_8 = param1.target.id;
         updateColorGrid();
         updatePreview();
      }
      
      private function updateColorGrid() : void
      {
         var _loc1_:IWindowController_1 = null;
         var _loc2_:IWindowModel = null;
         var _loc4_:int = 0;
         if(_window == null)
         {
            return;
         }
         var _loc3_:IItemGridWindow = _window.findChildByName("color_grid") as IItemGridWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.numGridItems)
         {
            _loc1_ = _loc3_.getGridItemAt(_loc4_) as IWindowController_1;
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_.findChildByName("selection");
               if(_loc2_ != null)
               {
                  _loc2_.visible = _loc1_.id == UnknownVarFromPurchaseConfirmationDialog_Int_8;
               }
            }
            _loc4_++;
         }
      }
      
      public function receiverNotFound() : void
      {
         if(disposed)
         {
            return;
         }
         enableGiftButton(true);
         if(!_catalog || !_catalog.windowManager)
         {
            return;
         }
         _catalog.windowManager.alert("${catalog.gift_wrapping.receiver_not_found.title}","${catalog.gift_wrapping.receiver_not_found.info}",0,alertHandler);
      }
      
      private function alertHandler(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
         enableGiftButton(true);
      }
      
      private function enableGiftButton(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:UnknownICoreWindowComponents4 = _window.findChildByName("give_gift_button") as UnknownICoreWindowComponents4;
         if(_loc2_ != null)
         {
            param1 ? _loc2_.enable() : Boolean(_loc2_.disable());
         }
      }
      
      public function notEnoughCredits() : void
      {
         if(disposed)
         {
            return;
         }
         if(_window == null)
         {
            return;
         }
         enableGiftButton(true);
         safeEnable("header_button_close");
         var _loc1_:UnknownICoreWindowComponents2 = _window.findChildByName("use_free_checkbox") as UnknownICoreWindowComponents2;
         if(_loc1_ != null)
         {
            _loc1_.select();
         }
      }
      
      public function ltdRaffleStarted() : void
      {
         var _loc1_:IWindowModel = _window.findChildByName("raffle_container");
         if(_loc1_ != null)
         {
            _loc1_.visible = true;
         }
         UnknownVarFromPurchaseConfirmationDialog_Int_9 = 1;
         updateDots();
         UnknownVarFromPurchaseConfirmationDialog_Timer_1 = new Timer(150);
         UnknownVarFromPurchaseConfirmationDialog_Timer_1.addEventListener("timer",onRaffleTimerTick);
         UnknownVarFromPurchaseConfirmationDialog_Timer_1.start();
      }
      
      public function ltdRaffleEnded() : void
      {
         var _loc1_:IWindowModel = null;
         if(!_disposed)
         {
            _loc1_ = _window.findChildByName("raffle_container");
            if(_loc1_ != null)
            {
               _loc1_.visible = false;
            }
            if(UnknownVarFromPurchaseConfirmationDialog_Timer_1 != null && UnknownVarFromPurchaseConfirmationDialog_Timer_1.running)
            {
               UnknownVarFromPurchaseConfirmationDialog_Timer_1.stop();
            }
            UnknownVarFromPurchaseConfirmationDialog_Timer_1 = null;
         }
      }
      
      private function onRaffleTimerTick(param1:TimerEvent) : void
      {
         UnknownVarFromPurchaseConfirmationDialog_Int_9 += 1;
         if(UnknownVarFromPurchaseConfirmationDialog_Int_9 > 14)
         {
            UnknownVarFromPurchaseConfirmationDialog_Int_9 = 1;
         }
         updateDots();
      }
      
      private function updateDots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ITextWindow = _window.findChildByName("raffle_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:String = _localization.getLocalization("catalog.purchase.confirmation.dialog.raffling");
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromPurchaseConfirmationDialog_Int_9)
         {
            _loc3_ += ".";
            _loc1_ += 1;
         }
         _loc2_.text = _loc3_;
      }
      
      public function turnIntoGifting() : void
      {
         var _loc1_:IWindowModel = _window.findChildByName("buy_button");
         _loc1_.removeEventListener("WME_CLICK",onBuyButtonClick);
         _loc1_.addEventListener("WME_CLICK",onGiftButtonClick);
         _loc1_.caption = "${catalog.purchase_confirmation.gift}";
         _window.caption = "${catalog.purchase_confirmation.gift.title}";
      }
   }
}

