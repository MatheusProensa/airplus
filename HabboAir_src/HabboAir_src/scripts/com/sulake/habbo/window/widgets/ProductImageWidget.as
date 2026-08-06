package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.enum.PivotPoint;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.theme.IPropertyMap;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.EffectPreviewer;
   import com.sulake.habbo.window.utils.UnknownHabboWindowUtils2;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class ProductImageWidget implements IProductImageWidget, UnknownIHabboRoom1
   {
      public static const TYPE:String = "product_image";
      
      private var UnknownVarFromProductImageWidget_Number_1:Number;
      
      private var UnknownVarFromProductImageWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromProductImageWidget_EffectPreviewer_1:EffectPreviewer;
      
      private var UnknownVarFromProductImageWidget_IWindowController_1_1:IWindowController_1;
      
      private var _disposed:Boolean;
      
      private var _productInfo:IProductDisplayInfo;
      
      private var _pivot:uint;
      
      private var _blend:Number = 1;
      
      private var UnknownVarFromProductImageWidget_Int_1:int = -1;
      
      private var UnknownVarFromProductImageWidget_String_1:String = "";
      
      private var UnknownVarFromProductImageWidget_Int_2:int = 0;
      
      public function ProductImageWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromProductImageWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromProductImageWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("product_image_xml").content)));
         UnknownVarFromProductImageWidget_EffectPreviewer_1 = new EffectPreviewer(effectImageWidget,param2.avatarRenderer);
         UnknownVarFromProductImageWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromProductImageWidget_IWindowController_1_1;
         UnknownVarFromProductImageWidget_IWindowController_1_1.width = UnknownVarFromProductImageWidget_IWidgetWindowController_1.width;
         UnknownVarFromProductImageWidget_IWindowController_1_1.height = UnknownVarFromProductImageWidget_IWidgetWindowController_1.height;
         setPlaceholder();
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
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         var _loc1_:IPropertyMap = _windowManager.getThemeManager().getPropertyDefaults(UnknownVarFromProductImageWidget_IWidgetWindowController_1.style);
         _loc2_.push(_loc1_.get("pivot_point").withValue(PivotPoint.PIVOT_NAMES[_pivot]));
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("pivot_point" === _loc3_)
            {
               pivot = PivotPoint.pivotFromName(String(_loc2_.value));
            }
         }
      }
      
      public function get pivot() : uint
      {
         return _pivot;
      }
      
      public function set pivot(param1:uint) : void
      {
         _pivot = param1;
         (productPreviewBitmap as UnknownICoreWindowUtils4).pivotPoint = param1;
         (badgeImageWidget.widget as BadgeImageWidget).pivotPoint = param1;
         placeholderImage.pivotPoint = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         if(_productInfo != null)
         {
            previewImage(_productInfo);
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function previewImage(param1:IProductDisplayInfo) : void
      {
         var _loc6_:String = null;
         var _loc3_:IFurnitureData = null;
         _loc3_ = null;
         var _loc5_:int = 0;
         var _loc2_:UnknownHabboRoom1 = null;
         var _loc4_:BitmapData = null;
         if(param1 == null)
         {
            setUnknownImage();
            return;
         }
         if(handlePreviewImageEasterEgg(param1))
         {
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
               _loc5_ = UnknownHabboWindowUtils2.categoryMapping("I",_loc3_.id);
               if(_loc5_ == 1)
               {
                  imageResult = _windowManager.roomEngine.getWallItemImage(_loc3_.id,new Vector3d(90),64,this,0,param1.extraData);
               }
               else
               {
                  clearPreviewer();
               }
               break;
            case 2:
               _loc3_ = _windowManager.sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc3_ == null)
               {
                  clearPreviewer();
                  break;
               }
               imageResult = _windowManager.roomEngine.getFurnitureImage(_loc3_.id,new Vector3d(90,0,0),64,this);
               break;
            case 3:
               if(param1.itemTypeId == "")
               {
                  clearPreviewer();
                  break;
               }
               setEffectResult(_windowManager.sessionDataManager.figure,parseInt(param1.itemTypeId));
               break;
            case 5:
               badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc2_ = new UnknownHabboRoom1();
               _loc4_ = UnknownHabboWindowUtils2.createChatItemPreview(_windowManager,parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  clearPreviewer();
                  break;
               }
               _loc2_.data = _loc4_;
               imageResult = _loc2_;
               break;
            case 11:
               petResult = param1.petFigureString;
               break;
            case 12:
               avatarResult = _loc6_ = _windowManager.avatarRenderer.getFigureStringWithFigureIds(_windowManager.sessionDataManager.figure,_windowManager.sessionDataManager.gender,param1.figureSetIds);
               break;
            default:
               Logger.log("[ProductImageWidget] Can not yet handle this type of product: ");
               clearPreviewer();
         }
      }
      
      private function handlePreviewImageEasterEgg(param1:IProductDisplayInfo) : Boolean
      {
         var _loc4_:String = null;
         var _loc2_:UnknownHabboRoom1 = null;
         var _loc3_:BitmapData = null;
         if(param1.productTypeId == UnknownVarFromProductImageWidget_Int_1 && param1.itemTypeId == UnknownVarFromProductImageWidget_String_1)
         {
            UnknownVarFromProductImageWidget_Int_2 += 1;
         }
         else
         {
            UnknownVarFromProductImageWidget_Int_2 = 1;
         }
         UnknownVarFromProductImageWidget_Int_1 = param1.productTypeId;
         UnknownVarFromProductImageWidget_String_1 = param1.itemTypeId;
         if(param1.productTypeId == 9)
         {
            _loc4_ = "";
            if(UnknownVarFromProductImageWidget_Int_2 == 7)
            {
               _loc4_ = "Evil Frank";
            }
            if(UnknownVarFromProductImageWidget_Int_2 == 10)
            {
               _loc4_ = "Bonne Blonde";
            }
            if(UnknownVarFromProductImageWidget_Int_2 == 15)
            {
               _loc4_ = "Furni fairy";
            }
            if(UnknownVarFromProductImageWidget_Int_2 == 22)
            {
               _loc4_ = "Wacky Wired";
            }
            if(UnknownVarFromProductImageWidget_Int_2 == 35)
            {
               _loc4_ = "Quacky duck";
            }
            if(UnknownVarFromProductImageWidget_Int_2 == 70)
            {
               _loc4_ = "Pixel poo";
            }
            if(UnknownVarFromProductImageWidget_Int_2 == 100)
            {
               _loc4_ = "Bobba filtered";
            }
            if(_loc4_ != "")
            {
               _loc2_ = new UnknownHabboRoom1();
               _loc3_ = UnknownHabboWindowUtils2.createChatItemPreview(_windowManager,parseInt(param1.itemTypeId),_loc4_);
               if(_loc3_ == null)
               {
                  return false;
               }
               _loc2_.data = _loc3_;
               imageResult = _loc2_;
               return true;
            }
         }
         return false;
      }
      
      public function clearPreviewer() : void
      {
         UnknownVarFromProductImageWidget_Number_1 = -1;
         avatarImageWidget.visible = false;
         productPreviewBitmap.visible = false;
         badgeImageWidget.visible = false;
         placeholderImage.visible = false;
         petImageWidget.visible = false;
         UnknownVarFromProductImageWidget_EffectPreviewer_1.visible = false;
         unknownImageWindow.visible = false;
      }
      
      private function set imageResult(param1:UnknownHabboRoom1) : void
      {
         clearPreviewer();
         if(param1 != null)
         {
            UnknownVarFromProductImageWidget_Number_1 = param1.id;
            setPreviewImage(param1.data);
         }
      }
      
      private function centerWindow(param1:IWidgetWindowController) : void
      {
         param1.x = UnknownVarFromProductImageWidget_IWindowController_1_1.width / 2 - param1.width / 2;
         param1.y = UnknownVarFromProductImageWidget_IWindowController_1_1.height / 2 - param1.height / 2;
      }
      
      private function set avatarResult(param1:String) : void
      {
         clearPreviewer();
         avatarImageWidget.visible = true;
         var _loc2_:IAvatarImageWidget = avatarImageWidget.widget as IAvatarImageWidget;
         _loc2_.figure = param1;
         centerWindow(avatarImageWidget);
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
      
      private function setEffectResult(param1:String, param2:int) : void
      {
         clearPreviewer();
         centerWindow(effectImageWidget);
         effectImageWidget.y += 50;
         UnknownVarFromProductImageWidget_EffectPreviewer_1.visible = true;
         UnknownVarFromProductImageWidget_EffectPreviewer_1.update(param1,param2);
      }
      
      public function setUnknownImage() : void
      {
         clearPreviewer();
         unknownImageWindow.visible = true;
      }
      
      public function setPlaceholder() : void
      {
         clearPreviewer();
         placeholderImage.visible = true;
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
      
      public function set unknownImageUri(param1:String) : void
      {
         unknownImageWindow.assetUri = param1;
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
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(UnknownVarFromProductImageWidget_Number_1 == param1 && productPreviewBitmap != null)
         {
            setPreviewImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromProductImageWidget_EffectPreviewer_1 != null)
         {
            UnknownVarFromProductImageWidget_EffectPreviewer_1.dispose();
            UnknownVarFromProductImageWidget_EffectPreviewer_1 = null;
         }
         UnknownVarFromProductImageWidget_Number_1 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromProductImageWidget_IWindowController_1_1.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get productPreviewBitmap() : IBitmapWrapperController
      {
         return UnknownVarFromProductImageWidget_IWindowController_1_1.findChildByName("product_preview") as IBitmapWrapperController;
      }
      
      private function get avatarImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromProductImageWidget_IWindowController_1_1.findChildByName("avatar_image_widget") as IWidgetWindowController;
      }
      
      private function get badgeImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromProductImageWidget_IWindowController_1_1.findChildByName("badge_image_widget") as IWidgetWindowController;
      }
      
      private function get petImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromProductImageWidget_IWindowController_1_1.findChildByName("pet_image_widget") as IWidgetWindowController;
      }
      
      private function get effectImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromProductImageWidget_IWindowController_1_1.findChildByName("effect_image_widget") as IWidgetWindowController;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromProductImageWidget_IWindowController_1_1.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
   }
}

