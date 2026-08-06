package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.UnknownHabboWindowUtils2;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class ProductIconWidget implements IProductIconWidget, UnknownIHabboRoom1, UnknownIHabboAvatar1
   {
      public static const TYPE:String = "product_icon";
      
      private var UnknownVarFromProductIconWidget_Number_1:Number;
      
      private var UnknownVarFromProductIconWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromProductIconWidget_IWindowController_1_1:IWindowController_1;
      
      private var _disposed:Boolean;
      
      private var _productInfo:IProductDisplayInfo;
      
      private var _blend:Number;
      
      public function ProductIconWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromProductIconWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromProductIconWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("product_icon_xml").content)));
         UnknownVarFromProductIconWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromProductIconWidget_IWindowController_1_1;
         clearPreviewer();
      }
      
      public function set productInfo(param1:IProductDisplayInfo) : *
      {
         _productInfo = param1;
         previewImage(param1);
      }
      
      public function get productInfo() : IProductDisplayInfo
      {
         return _productInfo;
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function previewImage(param1:IProductDisplayInfo) : void
      {
         var _loc3_:IFurnitureData = null;
         _loc3_ = null;
         var _loc4_:int = 0;
         var _loc2_:UnknownHabboRoom1 = null;
         var _loc5_:int = 0;
         _loc2_ = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            setUnknownImage();
            return;
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               setUnknownImage();
               break;
            case 1:
               _loc3_ = _windowManager.sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc3_ == null)
               {
                  clearPreviewer();
                  break;
               }
               _loc4_ = UnknownHabboWindowUtils2.categoryMapping("I",_loc3_.id);
               if(_loc4_ == 1)
               {
                  imageResult = _windowManager.roomEngine.getWallItemIcon(_loc3_.id,this,param1.extraData);
                  break;
               }
               clearPreviewer();
               break;
            case 2:
            case 12:
               _loc3_ = _windowManager.sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc3_ == null)
               {
                  clearPreviewer();
                  break;
               }
               imageResult = _windowManager.roomEngine.getFurnitureIcon(_loc3_.id,this);
               break;
            case 3:
               _loc2_ = new UnknownHabboRoom1();
               _loc2_.data = _windowManager.catalog.getPixelEffectIcon(parseInt(param1.itemTypeId));
               imageResult = _loc2_;
               break;
            case 5:
               badgeResult = param1.itemTypeId;
               break;
            case 7:
               botResult = param1.botFigureString;
               break;
            case 9:
               _loc7_ = parseInt(param1.itemTypeId);
               _loc6_ = ActivityPointTypeEnum.getIconStyleFor(_loc7_,_windowManager.context.configuration,true);
               if(_loc6_ == 0)
               {
                  clearPreviewer();
                  break;
               }
               iconResult = _loc6_;
               break;
            case 10:
               _loc5_ = parseInt(param1.itemTypeId);
               _loc2_ = new UnknownHabboRoom1();
               _loc2_.data = _windowManager.freeFlowChat.chatStyleLibrary.getStyle(_loc5_).selectorPreview;
               imageResult = _loc2_;
               break;
            case 11:
               petResult = param1.petFigureString;
               break;
            case 13:
               habbiconResult = parseInt(param1.itemTypeId);
               break;
            default:
               Logger.log("[ProductIconWidget] Can not yet handle this type of product: ");
               clearPreviewer();
         }
      }
      
      public function clearPreviewer() : void
      {
         UnknownVarFromProductIconWidget_Number_1 = -1;
         productPreviewBitmap.visible = false;
         badgeImageWidget.visible = false;
         petImageWidget.visible = false;
         unknownImageWindow.visible = false;
         iconWindow.visible = false;
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
      }
      
      private function set imageResult(param1:UnknownHabboRoom1) : void
      {
         clearPreviewer();
         if(param1 != null)
         {
            UnknownVarFromProductIconWidget_Number_1 = param1.id;
            setPreviewImage(param1.data);
         }
      }
      
      private function set badgeResult(param1:String) : void
      {
         clearPreviewer();
         badgeImageWidget.visible = true;
         var _loc2_:IBadgeImageWidget = badgeImageWidget.widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
      }
      
      private function set petResult(param1:String) : void
      {
         clearPreviewer();
         petImageWidget.visible = true;
         var _loc2_:IPetImageWidget = petImageWidget.widget as IPetImageWidget;
         _loc2_.figure = param1;
      }
      
      private function set botResult(param1:String) : void
      {
         clearPreviewer();
         if(param1 == null || param1.length == 0 || _windowManager.avatarRenderer == null)
         {
            setUnknownImage();
            return;
         }
         var _loc3_:IAvatarImage_2 = _windowManager.avatarRenderer.createAvatarImage(param1,"h",null,this);
         if(_loc3_ == null)
         {
            setUnknownImage();
            return;
         }
         _loc3_.setDirection("head",3);
         var _loc2_:BitmapData = _loc3_.getCroppedImage("head");
         _loc3_.dispose();
         if(_loc2_ == null)
         {
            setUnknownImage();
            return;
         }
         setPreviewImage(_loc2_);
         _loc2_.dispose();
      }
      
      private function setUnknownImage() : void
      {
         clearPreviewer();
         unknownImageWindow.visible = true;
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         if(productPreviewBitmap == null)
         {
            return;
         }
         if(param1 == null)
         {
            productPreviewBitmap.visible = false;
            return;
         }
         productPreviewBitmap.bitmap = param1.clone();
         productPreviewBitmap.visible = true;
      }
      
      private function set iconResult(param1:int) : void
      {
         clearPreviewer();
         iconWindow.visible = true;
         iconWindow.style = param1;
         iconWindow.fitToSize();
      }
      
      private function set habbiconResult(param1:int) : void
      {
         var _loc3_:BitmapData = null;
         clearPreviewer();
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(param1,false);
         if(_loc2_ == null)
         {
            HabbiconAssetManager.addEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
            _loc3_ = new BitmapData(40,40,false,9408399);
            setPreviewImage(_loc3_);
            _loc3_.dispose();
            return;
         }
         setPreviewImage(_loc2_);
      }
      
      private function onHabbiconAssetsLoaded(param1:Event) : void
      {
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
         if(_productInfo == null || _productInfo.productTypeId != 12)
         {
            return;
         }
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(parseInt(_productInfo.itemTypeId),false);
         if(_loc2_ == null)
         {
            return;
         }
         setPreviewImage(_loc2_);
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(UnknownVarFromProductIconWidget_Number_1 == param1 && productPreviewBitmap != null)
         {
            setPreviewImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(!_disposed && _productInfo != null && _productInfo.productTypeId == 6 && _productInfo.botFigureString == param1)
         {
            botResult = param1;
         }
      }
      
      public function set unknownImageUri(param1:String) : void
      {
         unknownImageWindow.assetUri = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         UnknownVarFromProductIconWidget_Number_1 = -1;
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get productPreviewBitmap() : IBitmapWrapperController
      {
         return UnknownVarFromProductIconWidget_IWindowController_1_1.findChildByName("bitmap") as IBitmapWrapperController;
      }
      
      private function get badgeImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromProductIconWidget_IWindowController_1_1.findChildByName("badge_image_widget") as IWidgetWindowController;
      }
      
      private function get petImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromProductIconWidget_IWindowController_1_1.findChildByName("pet_image_widget") as IWidgetWindowController;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromProductIconWidget_IWindowController_1_1.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get iconWindow() : IIconWindow
      {
         return UnknownVarFromProductIconWidget_IWindowController_1_1.findChildByName("icon") as IIconWindow;
      }
      
      public function set blend(param1:Number) : *
      {
         _blend = param1;
         productPreviewBitmap.blend = blend;
         unknownImageWindow.blend = blend;
         badgeImageWidget.blend = blend;
         petImageWidget.blend = blend;
         (petImageWidget.widget as IPetImageWidget).refresh();
         (badgeImageWidget.widget as IBadgeImageWidget).refresh();
      }
      
      public function get blend() : Number
      {
         return _blend;
      }
   }
}

