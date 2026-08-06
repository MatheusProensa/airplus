package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.BundleProductContainer;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.ProductDisplayWrapper;
   import com.sulake.habbo.catalog.viewer.UnknownHabboCatalogViewer1;
   import com.sulake.habbo.catalog.viewer.UnknownIHabboCatalogViewer1;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetRoomChangedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductImageWidget;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   
   public class ProductViewCatalogWidget extends CatalogWidget implements ICatalogWidget, UnknownIHabboRoom1, UnknownIHabboCatalogViewer1
   {
      private static const WALL_PAPER:int = 2;
      
      private static const UnknownConstFromProductViewCatalogWidget_Int_1:int = 3;
      
      private static const LANDSCAPE:int = 4;
      
      private static const PREVIEW_AVATAR_DEFAULT_BODY_DIRECTION:int = 2;
      
      private static const PREVIEW_AVATAR_DEFAULT_HEAD_DIRECTION:int = 3;
      
      private static const UnknownConstFromProductViewCatalogWidget_Int_2:int = 8;
      
      private static const PREVIEW_MODE_NONE:int = 0;
      
      private static const PREVIEW_MODE_AVATAR:int = 1;
      
      private static const PREVIEW_MODE_FLOOR_FURNITURE:int = 2;
      
      private static const PREVIEW_MODE_WALL_ITEM:int = 3;
      
      private static const PREVIEW_ACTION_STAND:int = 0;
      
      private static const PREVIEW_ACTION_WALK:int = 1;
      
      private static const PREVIEW_ACTION_DANCE:int = 2;
      
      private static const PREVIEW_ACTION_SIT:int = 3;
      
      private static const PREVIEW_ACTION_LAY:int = 4;
      
      private static const PREVIEW_ACTION_WAVE:int = 5;
      
      private static const PREVIEW_ACTION_COUNT:int = 6;
      
      private static const PREVIEW_ZOOM_NORMAL:int = 1;
      
      private static const PREVIEW_ZOOM_IN:int = 2;
      
      private static const PREVIEW_ZOOM_IN_CAMERA_OFFSET_Y:int = 41;
      
      private static const PREVIEW_ZOOM_MOVE_SPEED_DENOMINATOR:Number = 9;
      
      private static const PREVIEW_ZOOM_SPEED_SLOW:Number = 0.12;
      
      private static const PREVIEW_SIT_OFFSETS:Vector3d = new Vector3d(2,2,0.55);
      
      private static const PREVIEW_LAY_OFFSETS:Vector3d = new Vector3d(1,1,0.8);
      
      private var UnknownVarFromProductViewCatalogWidget_BitmapData_1:BitmapData;
      
      private var _productName:IWindowModel;
      
      private var UnknownVarFromProductViewCatalogWidget_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_2:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromProductViewCatalogWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromProductViewCatalogWidget_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromProductViewCatalogWidget_IWindowModel_3:IWindowModel;
      
      private var UnknownVarFromProductViewCatalogWidget_IWindowModel_4:IWindowModel;
      
      private var UnknownVarFromProductViewCatalogWidget_IWindowModel_5:IWindowModel;
      
      private var UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var UnknownVarFromProductViewCatalogWidget_IProductImageWidget_1:IProductImageWidget;
      
      private var UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1:IDisplayObjectWrapperController;
      
      private var UnknownVarFromProductViewCatalogWidget_Sprite_1:Sprite;
      
      private var _roomCanvasDisplayObject:DisplayObject;
      
      private var UnknownVarFromProductViewCatalogWidget_Point_1:Point;
      
      private var _bundleGrid:IItemGridWindow;
      
      protected var _gridItemLayout:XML;
      
      private var _effectSprites:Array;
      
      private var _overrideStuffData:IStuffData;
      
      private var UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1:SelectProductEvent = null;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromProductViewCatalogWidget_IWindowModel_6:IWindowModel;
      
      private var UnknownVarFromProductViewCatalogWidget_Boolean_1:Boolean = true;
      
      private var UnknownVarFromProductViewCatalogWidget_Boolean_2:Boolean = false;
      
      private var UnknownVarFromProductViewCatalogWidget_Boolean_3:Boolean = true;
      
      private var _offer:UnknownIHabboCatalog1;
      
      private var UnknownVarFromProductViewCatalogWidget_Boolean_4:Boolean;
      
      private var _previewMode:int = 0;
      
      private var UnknownVarFromProductViewCatalogWidget_Boolean_5:Boolean;
      
      private var UnknownVarFromProductViewCatalogWidget_Int_1:int = 2;
      
      private var UnknownVarFromProductViewCatalogWidget_Int_2:int = 3;
      
      private var UnknownVarFromProductViewCatalogWidget_Int_3:int = 0;
      
      private var UnknownVarFromProductViewCatalogWidget_Int_4:int = 1;
      
      private var _previewZoomAnimationProgress:Number = 0;
      
      private var _previewZoomAnimationTargetProgress:Number = 0;
      
      private var UnknownVarFromProductViewCatalogWidget_Number_1:Number = 0;
      
      private var UnknownVarFromProductViewCatalogWidget_Number_2:Number = 0;
      
      private var UnknownVarFromProductViewCatalogWidget_Boolean_6:Boolean = false;
      
      public function ProductViewCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      private static function ninjaEffectBundled(param1:SelectProductEvent) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:IProduct = null;
         var _loc4_:Boolean = false;
         if(param1.offer.productContainer.products.length == 2)
         {
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc2_ = param1.offer.productContainer.products[_loc3_];
               if(_loc2_.productType == "e" && _loc2_.productClassId == 108)
               {
                  _loc4_ = true;
               }
               _loc3_++;
            }
         }
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onPreviewProduct);
            events.removeEventListener("CWE_ROOM_CHANGED",onRoomChanged);
            events.removeEventListener("CWE_SET_PREVIEWER_STUFFDATA",onStuffDataSet);
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
            events.removeEventListener("TOTAL_PRICE_WIDGET_INITIALIZED",onTotalPriceWidgetInitialized);
            HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
            if(UnknownVarFromProductViewCatalogWidget_IWindowModel_2 != null)
            {
               UnknownVarFromProductViewCatalogWidget_IWindowModel_2.removeEventListener("WME_CLICK",onRotateAvatarLeft);
               UnknownVarFromProductViewCatalogWidget_IWindowModel_2 = null;
            }
            if(UnknownVarFromProductViewCatalogWidget_IWindowModel_3 != null)
            {
               UnknownVarFromProductViewCatalogWidget_IWindowModel_3.removeEventListener("WME_CLICK",onRotateAvatarRight);
               UnknownVarFromProductViewCatalogWidget_IWindowModel_3 = null;
            }
            if(UnknownVarFromProductViewCatalogWidget_IWindowModel_4 != null)
            {
               UnknownVarFromProductViewCatalogWidget_IWindowModel_4.removeEventListener("WME_CLICK",onTogglePreviewMagic);
               UnknownVarFromProductViewCatalogWidget_IWindowModel_4 = null;
            }
            if(UnknownVarFromProductViewCatalogWidget_IWindowModel_5 != null)
            {
               UnknownVarFromProductViewCatalogWidget_IWindowModel_5.removeEventListener("WME_CLICK",onTogglePreviewZoom);
               UnknownVarFromProductViewCatalogWidget_IWindowModel_5 = null;
            }
            setFloorFurnitureRotationAvailabilityMonitorEnabled(false);
            stopPreviewZoomAnimation();
            _catalog = null;
            UnknownVarFromProductViewCatalogWidget_IWindowModel_6 = null;
            super.dispose();
            UnknownVarFromProductViewCatalogWidget_BitmapData_1 = null;
            UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 = null;
            UnknownVarFromProductViewCatalogWidget_Sprite_1 = null;
            _roomCanvasDisplayObject = null;
            UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1 = null;
            UnknownVarFromProductViewCatalogWidget_IProductImageWidget_1 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("productViewWidget");
         if(!_isEmbedded)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         if(_window.tags.indexOf("2X") > -1)
         {
         }
         UnknownVarFromProductViewCatalogWidget_Boolean_3 = _window.tags.indexOf("NO_ROOM_CANVAS") == -1;
         UnknownVarFromProductViewCatalogWidget_IWindowModel_6 = null;
         _productName = _window.findChildByName("ctlg_product_name");
         _productName.caption = "";
         UnknownVarFromProductViewCatalogWidget_IWindowModel_1 = _window.findChildByName("ctlg_description");
         UnknownVarFromProductViewCatalogWidget_IWindowModel_1.caption = "";
         UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_1 = _window.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow;
         if(UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_1 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_1.visible = false;
         }
         UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_2 = _window.findChildByName("recyclable_icon") as IStaticBitmapWrapperWindow;
         if(UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_2 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_2.visible = false;
         }
         (_productName as ITextWindow).textColor = 0;
         (UnknownVarFromProductViewCatalogWidget_IWindowModel_1 as ITextWindow).textColor = 0;
         UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1 = _window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperController;
         UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 = _window.findChildByName("room_canvas_container") as IWindowController_1;
         if(UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.visible = false;
            UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 = UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.findChildByName("room_canvas") as IDisplayObjectWrapperController;
            if(UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 != null && _catalog.roomPreviewer != null)
            {
               UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.procedure = roomCanvasContainerProcedure;
               refreshRoomCanvasBinding(true);
            }
            else
            {
               UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 = null;
               UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 = null;
            }
         }
         UnknownVarFromProductViewCatalogWidget_IWindowModel_2 = _window.findChildByName("rotate_avatar_left");
         if(UnknownVarFromProductViewCatalogWidget_IWindowModel_2 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IWindowModel_2.visible = false;
            UnknownVarFromProductViewCatalogWidget_IWindowModel_2.addEventListener("WME_CLICK",onRotateAvatarLeft);
         }
         UnknownVarFromProductViewCatalogWidget_IWindowModel_3 = _window.findChildByName("rotate_avatar_right");
         if(UnknownVarFromProductViewCatalogWidget_IWindowModel_3 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IWindowModel_3.visible = false;
            UnknownVarFromProductViewCatalogWidget_IWindowModel_3.addEventListener("WME_CLICK",onRotateAvatarRight);
         }
         UnknownVarFromProductViewCatalogWidget_IWindowModel_4 = _window.findChildByName("toggle_preview_magic");
         if(UnknownVarFromProductViewCatalogWidget_IWindowModel_4 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IWindowModel_4.visible = false;
            UnknownVarFromProductViewCatalogWidget_IWindowModel_4.addEventListener("WME_CLICK",onTogglePreviewMagic);
         }
         UnknownVarFromProductViewCatalogWidget_IWindowModel_5 = _window.findChildByName("toggle_preview_zoom");
         if(UnknownVarFromProductViewCatalogWidget_IWindowModel_5 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IWindowModel_5.visible = false;
            UnknownVarFromProductViewCatalogWidget_IWindowModel_5.addEventListener("WME_CLICK",onTogglePreviewZoom);
         }
         UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1 = _window.findChildByName("product_image_widget") as IWidgetWindowController;
         if(UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IProductImageWidget_1 = UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1.widget as IProductImageWidget;
            UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1.visible = false;
         }
         UnknownVarFromProductViewCatalogWidget_Point_1 = new Point(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.x,UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.y);
         _bundleGrid = _window.findChildByName("bundleGrid") as IItemGridWindow;
         if(_bundleGrid == null)
         {
            Logger.log("[Product View Catalog Widget] Bundle Grid not initialized!");
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc2_.content as XML;
         var _loc1_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName("ctlg_dyndeal_background") as BitmapDataAsset;
         UnknownVarFromProductViewCatalogWidget_BitmapData_1 = _loc1_.content as BitmapData;
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         events.addEventListener("CWE_ROOM_CHANGED",onRoomChanged);
         events.addEventListener("CWE_SET_PREVIEWER_STUFFDATA",onStuffDataSet);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
         events.addEventListener("TOTAL_PRICE_WIDGET_INITIALIZED",onTotalPriceWidgetInitialized);
         return true;
      }
      
      private function refreshRoomCanvasBinding(param1:Boolean = false) : void
      {
         if(UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 == null)
         {
            return;
         }
         var _loc3_:RoomPreviewer = _catalog.roomPreviewer;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.disableUpdate = false;
         if(param1)
         {
            _loc3_.reset(false);
         }
         var _loc2_:DisplayObject = _loc3_.getRoomCanvas(UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.width,UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.height);
         if(_loc2_ != null)
         {
            bindRoomCanvasDisplayObject(_loc2_);
            applyRoomCanvasZoom();
         }
      }
      
      private function bindRoomCanvasDisplayObject(param1:DisplayObject) : void
      {
         if(UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 == null || param1 == null)
         {
            return;
         }
         if(UnknownVarFromProductViewCatalogWidget_Sprite_1 == null)
         {
            UnknownVarFromProductViewCatalogWidget_Sprite_1 = new Sprite();
            UnknownVarFromProductViewCatalogWidget_Sprite_1.mouseEnabled = false;
            UnknownVarFromProductViewCatalogWidget_Sprite_1.mouseChildren = false;
            UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.setDisplayObject(UnknownVarFromProductViewCatalogWidget_Sprite_1);
            if(_previewZoomAnimationProgress != _previewZoomAnimationTargetProgress)
            {
               startPreviewZoomAnimation();
            }
            setFloorFurnitureRotationAvailabilityMonitorEnabled(_previewMode == 2);
         }
         UnknownVarFromProductViewCatalogWidget_Sprite_1.scrollRect = new Rectangle(0,0,UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.width,UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.height);
         if(_roomCanvasDisplayObject != param1 || param1.parent != UnknownVarFromProductViewCatalogWidget_Sprite_1)
         {
            if(_roomCanvasDisplayObject != null && _roomCanvasDisplayObject.parent == UnknownVarFromProductViewCatalogWidget_Sprite_1)
            {
               UnknownVarFromProductViewCatalogWidget_Sprite_1.removeChild(_roomCanvasDisplayObject);
            }
            if(param1.parent != null)
            {
               param1.parent.removeChild(param1);
            }
            UnknownVarFromProductViewCatalogWidget_Sprite_1.addChild(param1);
            _roomCanvasDisplayObject = param1;
         }
      }
      
      private function onRoomChanged(param1:CatalogWidgetRoomChangedEvent) : void
      {
         refreshRoomCanvasBinding();
         if(UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1 != null)
         {
            onPreviewProduct(UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1);
         }
      }
      
      private function onRotateAvatarLeft(param1:WindowMouseEvent) : void
      {
         rotateCurrentPreview(1);
         param1.stopPropagation();
      }
      
      private function onRotateAvatarRight(param1:WindowMouseEvent) : void
      {
         rotateCurrentPreview(-1);
         param1.stopPropagation();
      }
      
      private function onTogglePreviewMagic(param1:WindowMouseEvent) : void
      {
         cyclePreviewAvatarAction();
         param1.stopPropagation();
      }
      
      private function onTogglePreviewZoom(param1:WindowMouseEvent) : void
      {
         togglePreviewZoom();
         param1.stopPropagation();
      }
      
      private function roomCanvasContainerProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         switch(param1.type)
         {
            case "WME_CLICK":
               if(_catalog.roomPreviewer != null)
               {
                  _catalog.roomPreviewer.changeRoomObjectState();
               }
               break;
            case "WME_UP":
            case "WME_OVER":
               UnknownVarFromProductViewCatalogWidget_Boolean_4 = false;
               break;
            case "WME_DOWN":
               UnknownVarFromProductViewCatalogWidget_Boolean_4 = true;
               break;
            case "WME_OUT":
               if(UnknownVarFromProductViewCatalogWidget_Boolean_4)
               {
                  if(_catalog.isDraggable(_offer))
                  {
                     _catalog.requestSelectedItemToMover(this,_offer);
                  }
               }
               UnknownVarFromProductViewCatalogWidget_Boolean_4 = false;
         }
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc30_:String = null;
         var _loc35_:BitmapData = null;
         var _loc29_:Point = null;
         var _loc4_:RoomPreviewer = null;
         var _loc2_:BundleProductContainer = null;
         var _loc26_:IProduct = null;
         var _loc8_:UnknownHabboRoom1 = null;
         var _loc21_:IFurnitureData = null;
         var _loc17_:* = undefined;
         var _loc25_:Array = null;
         var _loc31_:String = null;
         var _loc24_:String = null;
         var _loc10_:String = null;
         var _loc23_:String = null;
         var _loc3_:String = null;
         var _loc36_:String = null;
         var _loc14_:IFurnitureData = null;
         var _loc34_:IAvatarImage_2 = null;
         var _loc27_:String = null;
         var _loc15_:IHabboWindowManagerComponent = null;
         var _loc5_:IWindowController_1 = null;
         var _loc20_:* = 0;
         var _loc18_:BitmapData = null;
         var _loc9_:HabboCatalog = null;
         var _loc32_:IAvatarImage_2 = null;
         var _loc6_:Point = null;
         var _loc7_:IAvatarDataContainer = null;
         var _loc28_:IAnimationLayerData = null;
         var _loc33_:int = 0;
         var _loc11_:Point = null;
         var _loc13_:int = 0;
         var _loc12_:Boolean = false;
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1 = param1;
         removeEffectSprites();
         var _loc16_:UnknownIHabboCatalog1;
         _offer = _loc16_ = param1.offer;
         if(_bundleGrid != null)
         {
            _bundleGrid.visible = false;
            _bundleGrid.destroyGridItems();
         }
         _productName.caption = _loc16_.localizationName;
         UnknownVarFromProductViewCatalogWidget_IWindowModel_1.caption = _loc16_.localizationDescription;
         updateAvailabilityIndicators(_loc16_);
         if(_catalog.multiplePurchaseEnabled && _loc16_.bundlePurchaseAllowed && UnknownVarFromProductViewCatalogWidget_Boolean_2)
         {
            setSpinnerToBundleRuleset();
            setBundleInfoWidgetToOffer(_loc16_);
            UnknownVarFromProductViewCatalogWidget_Boolean_1 = false;
         }
         else
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_HIDE"));
            events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_HIDE"));
            UnknownVarFromProductViewCatalogWidget_Boolean_1 = true;
         }
         if(UnknownVarFromProductViewCatalogWidget_Boolean_1)
         {
            UnknownVarFromProductViewCatalogWidget_IWindowModel_6 = _catalog.utils.showPriceOnProduct(_loc16_,_window,UnknownVarFromProductViewCatalogWidget_IWindowModel_6,UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1,-6,false,6,page.acceptSeasonCurrencyAsCredits,page.acceptSeasonCurrencyAsCredits);
         }
         else if(UnknownVarFromProductViewCatalogWidget_IWindowModel_6 != null)
         {
            _window.removeChild(UnknownVarFromProductViewCatalogWidget_IWindowModel_6);
            UnknownVarFromProductViewCatalogWidget_IWindowModel_6.dispose();
            UnknownVarFromProductViewCatalogWidget_IWindowModel_6 = null;
         }
         if(_loc16_.badgeCode != null && _loc16_.badgeCode != "")
         {
            _catalog.utils.showExtraOnProduct(4,_loc16_.badgeCode,_window,6,44,false,false);
         }
         else if(_loc16_.extraChatStyleCode && _loc16_.extraChatStyleCode != "")
         {
            _catalog.utils.showExtraOnProduct(9,_loc16_.extraChatStyleCode,_window,6,44,false,false);
         }
         else if(ninjaEffectBundled(param1))
         {
            _catalog.utils.showAssetImageAsBadgeOnProduct("catalogue_effects_ninja",_window,6,44,true,false);
         }
         else
         {
            _catalog.utils.hideExtraFromProduct(_window);
         }
         if(UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1.visible = false;
         }
         if(UnknownHabboCatalogViewer1.hasProductImage(_loc16_.localizationId))
         {
            setPreviewFromAsset(UnknownHabboCatalogViewer1.PRODUCT_IMAGES[_loc16_.localizationId]);
            if(UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.visible = false;
            }
         }
         else
         {
            _loc29_ = new Point(0,0);
            _loc4_ = _catalog.roomPreviewer;
            switch(_loc16_.pricingModel)
            {
               case "pricing_model_bundle":
                  _loc35_ = UnknownVarFromProductViewCatalogWidget_BitmapData_1.clone();
                  if(_bundleGrid != null)
                  {
                     _bundleGrid.visible = true;
                     _loc2_ = _loc16_.productContainer as BundleProductContainer;
                     _loc2_.populateItemGrid(_bundleGrid,_gridItemLayout);
                     _bundleGrid.scrollV = 0;
                  }
                  if(UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 != null)
                  {
                     UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.visible = false;
                  }
                  break;
               case "pricing_model_single":
               case "pricing_model_multi":
               case "pricing_model_furniture":
                  _loc26_ = _loc16_.product;
                  if(UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 != null && UnknownVarFromProductViewCatalogWidget_Boolean_3)
                  {
                     if(_loc26_.productType == "s" || _loc26_.productType == "i" || _loc26_.productType == "e")
                     {
                        UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.visible = true;
                     }
                     else
                     {
                        UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.visible = false;
                     }
                  }
                  if(_loc4_ != null && UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 != null)
                  {
                     _loc4_.addViewOffset.y = _loc26_.isUniqueLimitedItem ? -15 : 0;
                     _loc4_.disableUpdate = false;
                  }
                  switch(_loc26_.productType)
                  {
                     case "s":
                        if(_loc4_ != null && UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 != null)
                        {
                           if(!(_loc26_ == null || _loc26_.furnitureData == null))
                           {
                              if(_loc26_.furnitureData.category == 23)
                              {
                                 _loc21_ = _catalog.sessionDataManager.getFloorItemData(_loc26_.furnitureData.id);
                                 _loc17_ = new Vector.<int>(0);
                                 _loc25_ = _loc21_.customParams.split(",");
                                 for each(var _loc22_ in _loc25_)
                                 {
                                    if((page.viewer.catalog as HabboCatalog).avatarRenderManager.isValidFigureSetForGender(parseInt(_loc22_),(page.viewer.catalog as HabboCatalog).sessionDataManager.gender))
                                    {
                                       _loc17_.push(parseInt(_loc22_));
                                    }
                                 }
                                 _loc30_ = (page.viewer.catalog as HabboCatalog).avatarRenderManager.getFigureStringWithFigureIds((page.viewer.catalog as HabboCatalog).sessionDataManager.figure,(page.viewer.catalog as HabboCatalog).sessionDataManager.gender,_loc17_);
                                 _loc4_.addAvatarIntoRoom(_loc30_);
                                 applyPreviewAvatarDirection(_loc4_);
                                 applyPreviewAvatarAction(_loc4_);
                                 _loc13_ = 1;
                              }
                              else
                              {
                                 _loc4_.addFurnitureIntoRoom(_loc26_.productClassId,new Vector3d(90,0,0),_overrideStuffData);
                                 _loc13_ = 2;
                                 _loc12_ = _loc4_.canRotatePreviewFurniture();
                              }
                           }
                           break;
                        }
                        _loc8_ = page.viewer.roomEngine.getFurnitureImage(_loc26_.productClassId,new Vector3d(90,0,0),64,this,0,_loc26_.extraParam,-1,-1,_overrideStuffData);
                        _loc16_.previewCallbackId = _loc8_.id;
                        break;
                     case "i":
                        if(_loc26_.furnitureData.category == 2 || _loc26_.furnitureData.category == 3 || _loc26_.furnitureData.category == 4)
                        {
                           _loc31_ = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_wall_type");
                           _loc24_ = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_floor_type");
                           _loc10_ = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_landscape_type");
                           _loc31_ = _loc31_ && _loc31_.length > 0 ? _loc31_ : "101";
                           _loc24_ = _loc24_ && _loc24_.length > 0 ? _loc24_ : "101";
                           _loc10_ = _loc10_ && _loc10_.length > 0 ? _loc10_ : "1.1";
                           _loc4_.updateRoomWallsAndFloorVisibility(true,true);
                           _loc23_ = _loc26_.furnitureData.category == 3 ? _loc26_.extraParam : _loc24_;
                           _loc3_ = _loc26_.furnitureData.category == 2 ? _loc26_.extraParam : _loc31_;
                           _loc36_ = _loc26_.furnitureData.category == 4 ? _loc26_.extraParam : _loc10_;
                           _loc4_.updateObjectRoom(_loc23_,_loc3_,_loc36_);
                           if(_loc26_.furnitureData.category == 4)
                           {
                              _loc14_ = _catalog.getFurnitureDataByName("ads_twi_windw","i");
                              _loc4_.addWallItemIntoRoom(_loc14_.id,new Vector3d(90,0,0),_loc14_.customParams);
                           }
                        }
                        else if(_loc4_ != null && UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 != null)
                        {
                           _loc4_.addWallItemIntoRoom(_loc26_.productClassId,new Vector3d(90,0,0),_loc26_.extraParam);
                           _loc13_ = _loc4_.canRotatePreviewWallItem() ? 3 : 0;
                        }
                        else
                        {
                           _loc8_ = page.viewer.roomEngine.getWallItemImage(_loc26_.productClassId,new Vector3d(90,0,0),64,this,0,_loc26_.extraParam);
                           _loc16_.previewCallbackId = _loc8_.id;
                        }
                        break;
                     case "r":
                        _loc34_ = _catalog.avatarRenderManager.createAvatarImage(_loc26_.extraParam,"h",null);
                        _loc34_.appendAction("gest","sml");
                        _loc34_.setDirection("full",4);
                        _loc34_.setDirection("head",3);
                        _loc35_ = _loc34_.getCroppedImage("full");
                        break;
                     case "e":
                        if(_loc4_ != null && UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 != null)
                        {
                           _loc27_ = (page.viewer.catalog as HabboCatalog).sessionDataManager.figure;
                           _loc4_.addAvatarIntoRoom(_loc27_,_loc26_.productClassId);
                           applyPreviewAvatarDirection(_loc4_);
                           applyPreviewAvatarAction(_loc4_);
                           _loc13_ = 1;
                        }
                        else
                        {
                           _loc15_ = page.viewer.catalog.windowManager;
                           _loc5_ = _window.findChildByName("pixelsBackground") as IWindowController_1;
                           _loc20_ = 4291611852;
                           if(_loc5_ != null)
                           {
                              _loc5_.visible = true;
                              _loc20_ = uint(_loc5_.color);
                           }
                           _loc35_ = new BitmapData(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.width,UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.height,false,_loc20_);
                           _loc18_ = null;
                           _loc9_ = page.viewer.catalog as HabboCatalog;
                           if(_loc9_.avatarRenderManager != null)
                           {
                              _loc30_ = _loc9_.sessionDataManager.figure;
                              _loc32_ = _loc9_.avatarRenderManager.createAvatarImage(_loc30_,"h");
                              if(_loc32_ != null)
                              {
                                 _loc32_.setDirection("head",3);
                                 _loc32_.initActionAppends();
                                 _loc32_.appendAction("gest","sml");
                                 _loc32_.appendAction("fx",_loc26_.productClassId);
                                 _loc32_.endActionAppends();
                                 _loc32_.updateAnimationByFrames(1);
                                 _loc32_.updateAnimationByFrames(1);
                                 _loc18_ = _loc32_.getImage("full",true);
                                 _loc6_ = new Point(0,0);
                                 if(_loc18_ != null)
                                 {
                                    _loc7_ = _loc32_.avatarSpriteData;
                                    if(_loc7_ != null)
                                    {
                                    }
                                    _loc6_.x = (_loc35_.width - _loc18_.width) / 2;
                                    _loc6_.y = (_loc35_.height - _loc18_.height) / 2;
                                    for each(var _loc19_ in _loc32_.getSprites())
                                    {
                                       if(_loc19_.id == "avatar")
                                       {
                                          _loc28_ = _loc32_.getLayerData(_loc19_);
                                          _loc29_.x = _loc28_.dx;
                                          _loc29_.y = _loc28_.dy;
                                       }
                                    }
                                 }
                                 _loc33_ = 64;
                                 _loc11_ = new Point((_loc18_.width - _loc33_) / 2,_loc18_.height - _loc33_ / 4);
                                 addEffectSprites(_loc35_,_loc32_,_loc29_,_loc6_.add(_loc11_),false);
                                 _loc35_.copyPixels(_loc18_,_loc18_.rect,_loc6_,null,null,true);
                                 addEffectSprites(_loc35_,_loc32_,_loc29_,_loc6_.add(_loc11_));
                              }
                           }
                           if(_loc32_)
                           {
                              _loc32_.dispose();
                           }
                        }
                        break;
                     case "h":
                        break;
                     case "habbicon":
                        _loc35_ = getHabbiconPreviewBitmap(_loc26_.extraParam);
                        if(_loc35_ == null)
                        {
                           HabbiconAssetManager.addEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
                           _loc35_ = new BitmapData(40,40,false,9408399);
                        }
                        break;
                     default:
                        if(ProductDisplayWrapper.isSupported(_loc26_.productType) && UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1 != null)
                        {
                           UnknownVarFromProductViewCatalogWidget_IWidgetWindowController_1.visible = true;
                           UnknownVarFromProductViewCatalogWidget_IProductImageWidget_1.productInfo = new ProductDisplayWrapper(_loc26_);
                        }
                        else
                        {
                           Logger.log("[Product View Catalog Widget] Unknown Product Type: " + _loc26_.productType);
                        }
                  }
                  if(_loc8_ != null)
                  {
                     _loc35_ = _loc8_.data;
                  }
                  break;
               default:
                  Logger.log("[Product View Catalog Widget] Unknown pricing model" + _loc16_.pricingModel);
            }
            setPreviewImage(_loc35_,true,_loc29_);
         }
         setPreviewMode(_loc13_,_loc12_);
         if(UnknownVarFromProductViewCatalogWidget_Boolean_3 && _loc4_ && UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 && UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 && UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.visible && UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.visible)
         {
            (_productName as ITextWindow).textColor = 4294967295;
            (UnknownVarFromProductViewCatalogWidget_IWindowModel_1 as ITextWindow).textColor = 4294967295;
         }
         else
         {
            (_productName as ITextWindow).textColor = 4278190080;
            (UnknownVarFromProductViewCatalogWidget_IWindowModel_1 as ITextWindow).textColor = 4278190080;
         }
         _window.invalidate();
      }
      
      private function rotateCurrentPreview(param1:int) : void
      {
         var _loc2_:RoomPreviewer = _catalog != null ? _catalog.roomPreviewer : null;
         if(_loc2_ == null)
         {
            return;
         }
         switch(_previewMode - 1)
         {
            case 0:
               rotatePreviewAvatar(param1,_loc2_);
               break;
            case 1:
               _loc2_.rotatePreviewFurniture(param1 > 0);
               break;
            case 2:
               _loc2_.rotatePreviewWallItem();
         }
      }
      
      private function rotatePreviewAvatar(param1:int, param2:RoomPreviewer) : void
      {
         if(_previewMode != 1 || param2 == null)
         {
            return;
         }
         if(UnknownVarFromProductViewCatalogWidget_Int_3 == 3 && isDiagonalAvatarDirection(UnknownVarFromProductViewCatalogWidget_Int_1 + param1))
         {
            param1 *= 2;
         }
         else if(UnknownVarFromProductViewCatalogWidget_Int_3 == 4 && !isValidLayingDirection(UnknownVarFromProductViewCatalogWidget_Int_1 + param1))
         {
            if(UnknownVarFromProductViewCatalogWidget_Int_1 == 0)
            {
               param1 = 2;
            }
            else
            {
               param1 = -UnknownVarFromProductViewCatalogWidget_Int_1;
            }
         }
         UnknownVarFromProductViewCatalogWidget_Int_1 = normalizeAvatarDirection(UnknownVarFromProductViewCatalogWidget_Int_1 + param1);
         UnknownVarFromProductViewCatalogWidget_Int_2 = UnknownVarFromProductViewCatalogWidget_Int_1;
         applyPreviewAvatarDirection(param2);
      }
      
      private function cyclePreviewAvatarAction() : void
      {
         var _loc1_:RoomPreviewer = _catalog != null ? _catalog.roomPreviewer : null;
         if(_previewMode != 1 || _loc1_ == null)
         {
            return;
         }
         UnknownVarFromProductViewCatalogWidget_Int_3 = getNextPreviewAvatarAction(UnknownVarFromProductViewCatalogWidget_Int_3);
         applyPreviewAvatarAction(_loc1_);
      }
      
      private function togglePreviewZoom() : void
      {
         if(_previewMode != 1)
         {
            return;
         }
         UnknownVarFromProductViewCatalogWidget_Int_4 = UnknownVarFromProductViewCatalogWidget_Int_4 == 1 ? 2 : 1;
         animatePreviewZoomToSelection();
         updatePreviewControls();
      }
      
      private function applyPreviewAvatarDirection(param1:RoomPreviewer) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.updateAvatarDirectionAndLocation(UnknownVarFromProductViewCatalogWidget_Int_1,UnknownVarFromProductViewCatalogWidget_Int_2,getPreviewAvatarLocation());
         param1.updatePreviewRoomView(true);
         param1.updateRoomEngine();
      }
      
      private function setPreviewMode(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:* = param1;
         if(!UnknownVarFromProductViewCatalogWidget_Boolean_3 || UnknownVarFromProductViewCatalogWidget_IWindowController_1_1 == null || !UnknownVarFromProductViewCatalogWidget_IWindowController_1_1.visible)
         {
            _loc3_ = 0;
         }
         if(_previewMode == 1 && _loc3_ != 1)
         {
            resetPreviewAvatarDirection();
            resetPreviewAvatarAction();
            resetPreviewZoom();
            setPreviewZoomAnimationTarget(0,true);
         }
         if(_previewMode != 1 && _loc3_ == 1)
         {
            UnknownVarFromProductViewCatalogWidget_Int_4 = 2;
            setPreviewZoomAnimationTarget(1,true);
         }
         _previewMode = _loc3_;
         UnknownVarFromProductViewCatalogWidget_Boolean_5 = _previewMode == 2 && param2;
         setFloorFurnitureRotationAvailabilityMonitorEnabled(_previewMode == 2);
         if(_previewMode == 1 && _previewZoomAnimationProgress != _previewZoomAnimationTargetProgress)
         {
            animatePreviewZoomToSelection();
         }
         updatePreviewControls();
      }
      
      private function setFloorFurnitureRotationAvailabilityMonitorEnabled(param1:Boolean) : void
      {
         if(UnknownVarFromProductViewCatalogWidget_Sprite_1 == null)
         {
            return;
         }
         if(param1)
         {
            if(!UnknownVarFromProductViewCatalogWidget_Sprite_1.hasEventListener("enterFrame"))
            {
               UnknownVarFromProductViewCatalogWidget_Sprite_1.addEventListener("enterFrame",onFloorFurnitureRotationAvailabilityFrame);
            }
         }
         else
         {
            UnknownVarFromProductViewCatalogWidget_Sprite_1.removeEventListener("enterFrame",onFloorFurnitureRotationAvailabilityFrame);
         }
      }
      
      private function onFloorFurnitureRotationAvailabilityFrame(param1:Event) : void
      {
         var _loc2_:RoomPreviewer = _catalog != null ? _catalog.roomPreviewer : null;
         if(_previewMode != 2 || _loc2_ == null)
         {
            setFloorFurnitureRotationAvailabilityMonitorEnabled(false);
            return;
         }
         var _loc3_:Boolean = _loc2_.canRotatePreviewFurniture();
         if(UnknownVarFromProductViewCatalogWidget_Boolean_5 != _loc3_)
         {
            UnknownVarFromProductViewCatalogWidget_Boolean_5 = _loc3_;
            updatePreviewControls();
         }
      }
      
      private function updatePreviewControls() : void
      {
         var _loc3_:* = _previewMode == 1;
         var _loc1_:* = _previewMode != 0;
         var _loc2_:Boolean = _loc1_ && (_previewMode != 2 || UnknownVarFromProductViewCatalogWidget_Boolean_5);
         setPreviewButtonState(UnknownVarFromProductViewCatalogWidget_IWindowModel_2,_loc1_,_loc2_);
         setPreviewButtonState(UnknownVarFromProductViewCatalogWidget_IWindowModel_3,_loc1_,_loc2_);
         setPreviewButtonState(UnknownVarFromProductViewCatalogWidget_IWindowModel_4,_loc3_,_loc3_);
         setPreviewButtonState(UnknownVarFromProductViewCatalogWidget_IWindowModel_5,_loc3_,_loc3_);
      }
      
      private function setPreviewButtonState(param1:IWindowModel, param2:Boolean, param3:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.visible = param2;
         if(param3)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
      
      private function resetPreviewAvatarDirection() : void
      {
         UnknownVarFromProductViewCatalogWidget_Int_1 = 2;
         UnknownVarFromProductViewCatalogWidget_Int_2 = 3;
      }
      
      private function resetPreviewAvatarAction() : void
      {
         UnknownVarFromProductViewCatalogWidget_Int_3 = 0;
      }
      
      private function getPreviewAvatarLocation() : Vector3d
      {
         switch(UnknownVarFromProductViewCatalogWidget_Int_3 - 3)
         {
            case 0:
               return PREVIEW_SIT_OFFSETS;
            case 1:
               return PREVIEW_LAY_OFFSETS;
            default:
               return null;
         }
      }
      
      private function applyPreviewAvatarAction(param1:RoomPreviewer) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.updateObjectUserAction("figure_dance",0);
         param1.updateObjectUserAction("figure_expression",0);
         switch(UnknownVarFromProductViewCatalogWidget_Int_3)
         {
            case 1:
               param1.updateUserPosture("mv");
               break;
            case 2:
               param1.updateUserPosture("std");
               param1.updateObjectUserAction("figure_dance",1);
               break;
            case 3:
               param1.updateUserPosture("sit");
               break;
            case 4:
               param1.updateUserPosture("lay");
               break;
            case 5:
               param1.updateUserPosture("std");
               param1.updateObjectUserAction("figure_expression",AvatarAction.getExpressionId("wave"));
               break;
            default:
               param1.updateUserPosture("std");
         }
         param1.updateAvatarDirectionAndLocation(UnknownVarFromProductViewCatalogWidget_Int_1,UnknownVarFromProductViewCatalogWidget_Int_2,getPreviewAvatarLocation());
         param1.updatePreviewRoomView(true);
         param1.updateRoomEngine();
      }
      
      private function getNextPreviewAvatarAction(param1:int) : int
      {
         var _loc2_:* = param1;
         do
         {
            _loc2_ = (_loc2_ + 1) % 6;
         }
         while(isPreviewAvatarActionSkippedForDirection(_loc2_,UnknownVarFromProductViewCatalogWidget_Int_1));
         
         return _loc2_;
      }
      
      private function isPreviewAvatarActionSkippedForDirection(param1:int, param2:int) : Boolean
      {
         return param1 == 3 && isDiagonalAvatarDirection(param2) || param1 == 4 && !isValidLayingDirection(param2);
      }
      
      private function resetPreviewZoom() : void
      {
         UnknownVarFromProductViewCatalogWidget_Int_4 = 1;
      }
      
      private function animatePreviewZoomToSelection() : void
      {
         setPreviewZoomAnimationTarget(UnknownVarFromProductViewCatalogWidget_Int_4 == 2 ? 1 : 0);
      }
      
      private function setPreviewZoomAnimationTarget(param1:Number, param2:Boolean = false) : void
      {
         param1 = Math.max(0,Math.min(1,param1));
         _previewZoomAnimationTargetProgress = param1;
         if(param2)
         {
            stopPreviewZoomAnimation();
            _previewZoomAnimationProgress = param1;
            UnknownVarFromProductViewCatalogWidget_Number_1 = 0;
            UnknownVarFromProductViewCatalogWidget_Number_2 = 0;
            UnknownVarFromProductViewCatalogWidget_Boolean_6 = false;
            applyRoomCanvasZoom();
            return;
         }
         var _loc3_:Number = Math.abs(_previewZoomAnimationTargetProgress - _previewZoomAnimationProgress);
         if(_loc3_ <= 0)
         {
            stopPreviewZoomAnimation();
            _previewZoomAnimationProgress = _previewZoomAnimationTargetProgress;
            UnknownVarFromProductViewCatalogWidget_Number_2 = 0;
            UnknownVarFromProductViewCatalogWidget_Boolean_6 = false;
            applyRoomCanvasZoom();
            return;
         }
         UnknownVarFromProductViewCatalogWidget_Number_1 = _loc3_;
         UnknownVarFromProductViewCatalogWidget_Boolean_6 = true;
         startPreviewZoomAnimation();
      }
      
      private function startPreviewZoomAnimation() : void
      {
         if(UnknownVarFromProductViewCatalogWidget_Sprite_1 == null || UnknownVarFromProductViewCatalogWidget_Sprite_1.hasEventListener("enterFrame"))
         {
            return;
         }
         UnknownVarFromProductViewCatalogWidget_Sprite_1.addEventListener("enterFrame",onPreviewZoomAnimationFrame);
      }
      
      private function stopPreviewZoomAnimation() : void
      {
         if(UnknownVarFromProductViewCatalogWidget_Sprite_1 != null && UnknownVarFromProductViewCatalogWidget_Sprite_1.hasEventListener("enterFrame"))
         {
            UnknownVarFromProductViewCatalogWidget_Sprite_1.removeEventListener("enterFrame",onPreviewZoomAnimationFrame);
         }
      }
      
      private function onPreviewZoomAnimationFrame(param1:Event) : void
      {
         var _loc4_:Number = _previewZoomAnimationTargetProgress - _previewZoomAnimationProgress;
         var _loc2_:Number = Math.abs(_loc4_);
         if(_loc2_ <= 0.12)
         {
            _previewZoomAnimationProgress = _previewZoomAnimationTargetProgress;
            UnknownVarFromProductViewCatalogWidget_Number_2 = 0;
            UnknownVarFromProductViewCatalogWidget_Boolean_6 = false;
            stopPreviewZoomAnimation();
            applyRoomCanvasZoom();
            return;
         }
         if(_loc2_ > UnknownVarFromProductViewCatalogWidget_Number_1)
         {
            UnknownVarFromProductViewCatalogWidget_Number_1 = _loc2_;
         }
         var _loc5_:Number = Math.sin(3.141592653589793 * _loc2_ / UnknownVarFromProductViewCatalogWidget_Number_1);
         var _loc6_:Number = 0.06;
         var _loc3_:Number = UnknownVarFromProductViewCatalogWidget_Number_1 / 9;
         var _loc7_:* = _loc6_ + (_loc3_ - _loc6_) * _loc5_;
         if(UnknownVarFromProductViewCatalogWidget_Boolean_6)
         {
            if(_loc7_ < UnknownVarFromProductViewCatalogWidget_Number_2)
            {
               _loc7_ = UnknownVarFromProductViewCatalogWidget_Number_2;
               if(_loc7_ > _loc2_)
               {
                  _loc7_ = _loc2_;
               }
            }
            else
            {
               UnknownVarFromProductViewCatalogWidget_Boolean_6 = false;
            }
         }
         UnknownVarFromProductViewCatalogWidget_Number_2 = _loc7_;
         _previewZoomAnimationProgress += _loc4_ > 0 ? _loc7_ : -_loc7_;
         applyRoomCanvasZoom();
      }
      
      private function applyRoomCanvasZoom() : void
      {
         if(UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1 == null || _roomCanvasDisplayObject == null)
         {
            return;
         }
         if(UnknownVarFromProductViewCatalogWidget_Sprite_1 != null)
         {
            UnknownVarFromProductViewCatalogWidget_Sprite_1.scrollRect = new Rectangle(0,0,UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.width,UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.height);
         }
         var _loc1_:Number = 1 + (2 - 1) * _previewZoomAnimationProgress;
         var _loc2_:Number = 41 * _previewZoomAnimationProgress;
         _roomCanvasDisplayObject.scaleX = _loc1_;
         _roomCanvasDisplayObject.scaleY = _loc1_;
         _roomCanvasDisplayObject.x = -(UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.width * _loc1_ - UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.width) / 2;
         _roomCanvasDisplayObject.y = -(UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.height * _loc1_ - UnknownVarFromProductViewCatalogWidget_IDisplayObjectWrapperController_1.height) / 2 - _loc2_;
      }
      
      private function normalizeAvatarDirection(param1:int) : int
      {
         param1 %= 8;
         if(param1 < 0)
         {
            param1 += 8;
         }
         return param1;
      }
      
      private function isDiagonalAvatarDirection(param1:int) : Boolean
      {
         return normalizeAvatarDirection(param1) % 2 != 0;
      }
      
      private function isValidLayingDirection(param1:int) : Boolean
      {
         var _loc2_:int = normalizeAvatarDirection(param1);
         return _loc2_ == 0 || _loc2_ == 2;
      }
      
      private function updateAvailabilityIndicators(param1:UnknownIHabboCatalog1) : void
      {
         var _loc2_:IProduct = param1 != null ? param1.product : null;
         var _loc3_:IFurnitureData = _loc2_ != null ? _loc2_.furnitureData : null;
         var _loc4_:Boolean = page == null || !page.isBuilderPage;
         var _loc5_:Boolean = _loc2_ != null && _loc3_ != null && (_loc2_.productType == "s" || _loc2_.productType == "i");
         if(UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_1 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_1.visible = _loc4_ && _loc5_ && !_loc3_.tradeable;
         }
         if(UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_2 != null)
         {
            UnknownVarFromProductViewCatalogWidget_IStaticBitmapWrapperWindow_2.visible = _loc4_ && _loc5_ && (!_loc3_.recyclable || !_loc3_.tradeable);
         }
      }
      
      private function onHabbiconAssetsLoaded(param1:Event) : void
      {
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
         if(!disposed && UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1 != null)
         {
            onPreviewProduct(UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1);
         }
      }
      
      private function getHabbiconPreviewBitmap(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(int(param1),false);
         return _loc2_ != null ? _loc2_.clone() : null;
      }
      
      private function setBundleInfoWidgetToOffer(param1:UnknownIHabboCatalog1) : void
      {
         var _loc2_:ExtraInfoItemData = new ExtraInfoItemData(5);
         _loc2_.activityPointType = param1.activityPointType;
         _loc2_.priceActivityPoints = param1.priceInActivityPoints;
         _loc2_.priceCredits = param1.priceInCredits;
         _loc2_.priceSilver = param1.priceInSilver;
         _loc2_.badgeCode = param1.badgeCode;
         events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_RESET",_loc2_));
      }
      
      private function setSpinnerToBundleRuleset() : void
      {
         if(_catalog.bundleDiscountEnabled)
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET",1,_catalog.utils.bundleDiscountFlatPriceSteps));
         }
         else
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET",1));
         }
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SHOW"));
         if(_catalog.bundleDiscountRuleset != null)
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MAX",_catalog.bundleDiscountRuleset.maxPurchaseSize));
         }
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MIN",1));
      }
      
      private function addEffectSprites(param1:BitmapData, param2:IAvatarImage_2, param3:Point, param4:Point, param5:Boolean = true) : void
      {
         var _loc9_:* = null;
         var _loc17_:int = 0;
         var _loc10_:IAnimationLayerData = null;
         var _loc19_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc20_:int = 0;
         var _loc7_:String = null;
         var _loc6_:BitmapDataAsset = null;
         var _loc8_:BitmapData = null;
         var _loc18_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc11_:Matrix = null;
         for each(_loc9_ in param2.getSprites())
         {
            _loc17_ = int(_window.getChildIndex(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1));
            _loc10_ = param2.getLayerData(_loc9_);
            _loc19_ = 0;
            _loc14_ = _loc9_.getDirectionOffsetX(param2.getDirection());
            _loc15_ = _loc9_.getDirectionOffsetY(param2.getDirection());
            _loc16_ = _loc9_.getDirectionOffsetZ(param2.getDirection());
            _loc20_ = 0;
            if(!param5)
            {
               if(_loc16_ >= 0)
               {
                  continue;
               }
            }
            else if(_loc16_ < 0)
            {
               continue;
            }
            if(_loc9_.hasDirections)
            {
               _loc20_ = param2.getDirection();
            }
            if(_loc10_ != null)
            {
               _loc19_ = _loc10_.animationFrame;
               _loc14_ += _loc10_.dx;
               _loc15_ += _loc10_.dy;
               _loc20_ += _loc10_.directionOffset;
            }
            if(_loc20_ < 0)
            {
               _loc20_ += 8;
            }
            if(_loc20_ > 7)
            {
               _loc20_ -= 8;
            }
            _loc7_ = param2.getScale() + "_" + _loc9_.member + "_" + _loc20_ + "_" + _loc19_;
            _loc6_ = param2.getAsset(_loc7_);
            if(_loc6_ != null)
            {
               _loc8_ = (_loc6_.content as BitmapData).clone();
               _loc18_ = 1;
               _loc12_ = param4.x - 1 * _loc6_.offset.x + _loc14_;
               _loc13_ = param4.y - 1 * _loc6_.offset.y + _loc15_;
               if(_loc9_.ink == 33)
               {
                  _loc11_ = new Matrix(1,0,0,1,_loc12_ - param3.x,_loc13_ - param3.y);
                  param1.draw(_loc8_,_loc11_,null,"add",null,false);
               }
               else
               {
                  param1.copyPixels(_loc8_,_loc8_.rect,new Point(_loc12_ - param3.x,_loc13_ - param3.y));
               }
            }
         }
      }
      
      private function removeEffectSprites() : void
      {
         for each(var _loc1_ in _effectSprites)
         {
            _window.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         _effectSprites = [];
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || page == null || page.offers == null)
         {
            return;
         }
         for each(var _loc3_ in page.offers)
         {
            if(_loc3_.previewCallbackId == param1)
            {
               setPreviewImage(param2,true);
               _loc3_.previewCallbackId = 0;
               break;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean, param3:Point = null) : void
      {
         var _loc4_:Point = null;
         if(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1 != null && !window.disposed)
         {
            if(param1 == null)
            {
               param1 = new BitmapData(1,1);
               param2 = true;
            }
            if(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.bitmap == null)
            {
               UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.width,UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.height,true,16777215);
            }
            UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.bitmap.rect,16777215);
            _loc4_ = new Point((UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.width - param1.width) / 2,(UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.height - param1.height) / 2);
            UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
            UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.invalidate();
            UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.x = UnknownVarFromProductViewCatalogWidget_Point_1.x;
            UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.y = UnknownVarFromProductViewCatalogWidget_Point_1.y;
            if(param3 != null)
            {
               UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.x += param3.x;
               UnknownVarFromProductViewCatalogWidget_IBitmapWrapperController_1.y += param3.y;
            }
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         if(!param1 || !page || !page.viewer || !page.viewer.catalog || !page.viewer.catalog.assets)
         {
            return;
         }
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            retrievePreviewAsset(param1);
            return;
         }
         setPreviewImage(_loc2_.content as BitmapData,false);
      }
      
      private function retrievePreviewAsset(param1:String) : void
      {
         if(!param1 || !page || !page.viewer || !page.viewer.catalog)
         {
            return;
         }
         var _loc4_:String = page.viewer.catalog.imageGalleryHost + param1 + ".gif";
         Logger.log("[Product View Catalog Widget] Retrieve Product Preview Asset: " + _loc4_);
         var _loc2_:URLRequest = new URLRequest(_loc4_);
         if(!page.viewer.catalog.assets)
         {
            return;
         }
         var _loc3_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc2_,"image/gif");
         if(!_loc3_)
         {
            return;
         }
         _loc3_.addEventListener("AssetLoaderEventComplete",onPreviewImageReady);
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            setPreviewFromAsset(_loc2_.assetName);
            _loc2_.removeEventListener("AssetLoaderEventComplete",onPreviewImageReady);
         }
      }
      
      private function onStuffDataSet(param1:SetRoomPreviewerStuffDataEvent) : void
      {
         var _loc2_:RoomPreviewer = null;
         _overrideStuffData = param1.stuffData;
         if(UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1 != null)
         {
            _loc2_ = (page.viewer.catalog as HabboCatalog).roomPreviewer;
            if(_loc2_ != null)
            {
               _loc2_.reset(false);
            }
            onPreviewProduct(UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1);
         }
      }
      
      private function onSpinnerEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         var _loc2_:IWindowController_1 = null;
         if(param1.type == "CWSE_VALUE_CHANGED")
         {
            _loc2_ = window.findChildByName("price_box_new") as IWindowController_1;
            if(_loc2_ != null && UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1 != null)
            {
               _catalog.utils.showPriceInContainer(_loc2_,UnknownVarFromProductViewCatalogWidget_SelectProductEvent_1.offer);
            }
         }
      }
      
      private function onTotalPriceWidgetInitialized(param1:Event) : void
      {
         UnknownVarFromProductViewCatalogWidget_Boolean_2 = true;
      }
      
      override public function closed() : void
      {
         var _loc1_:RoomPreviewer = (page.viewer.catalog as HabboCatalog).roomPreviewer;
         if(_loc1_)
         {
            _loc1_.disableUpdate = true;
         }
         setPreviewMode(0);
      }
      
      public function onDragAndDropDone(param1:Boolean, param2:String) : void
      {
      }
   }
}

