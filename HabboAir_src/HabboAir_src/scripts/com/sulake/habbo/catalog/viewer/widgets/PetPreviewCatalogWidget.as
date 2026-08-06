package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.PetColorResult;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PetPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget, UnknownIHabboRoom1
   {
      private var PET_TYPE_ID:int = 15;
      
      private var BREED:int = 1;
      
      private var COLOR:int = 16777215;
      
      private var PALETTE_ID:int = 2;
      
      private var PART_ID:int = -1;
      
      private var _productName:IWindowModel;
      
      private var UnknownVarFromPetPreviewCatalogWidget_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromPetPreviewCatalogWidget_Point_1:Point;
      
      private var UnknownVarFromPetPreviewCatalogWidget_Int_1:int;
      
      protected var _gridItemLayout:XML;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromPetPreviewCatalogWidget_IWindowModel_2:IWindowModel;
      
      public function PetPreviewCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         _catalog = null;
         UnknownVarFromPetPreviewCatalogWidget_IWindowModel_2 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _productName = _window.findChildByName("ctlg_product_name");
         _productName.caption = "";
         UnknownVarFromPetPreviewCatalogWidget_IWindowModel_1 = _window.findChildByName("ctlg_description");
         UnknownVarFromPetPreviewCatalogWidget_IWindowModel_1.caption = "";
         UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1 = _window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperController;
         UnknownVarFromPetPreviewCatalogWidget_Point_1 = new Point(UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.x,UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.y);
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         var _loc2_:UnknownHabboRoom1 = (page.viewer.catalog as HabboCatalog).roomEngine.getPetImage(PET_TYPE_ID,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0);
         if(_loc2_ != null)
         {
            setPreviewImage(_loc2_.data,true,new Point(0,0));
            UnknownVarFromPetPreviewCatalogWidget_Int_1 = _loc2_.id;
         }
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         return true;
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc30_:String = null;
         var _loc24_:String = null;
         var _loc31_:BitmapData = null;
         var _loc18_:IProduct = null;
         var _loc4_:UnknownHabboRoom1 = null;
         var _loc11_:IFurnitureData = null;
         var _loc21_:String = null;
         var _loc2_:Array = null;
         var _loc29_:int = 0;
         var _loc14_:Array = null;
         var _loc26_:Array = null;
         var _loc12_:Array = null;
         var _loc15_:Array = null;
         var _loc23_:int = 0;
         var _loc13_:String = null;
         var _loc6_:Array = null;
         var _loc19_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:int = 0;
         var _loc10_:PetColorResult = null;
         var _loc9_:PetColorResult = null;
         var _loc16_:int = 0;
         var _loc27_:int = 0;
         var _loc8_:PetCustomPart = null;
         var _loc22_:PetCustomPart = null;
         if(param1 == null)
         {
            return;
         }
         var _loc7_:UnknownIHabboCatalog1 = param1.offer;
         var _loc25_:IProductData = page.viewer.catalog.getProductData(_loc7_.localizationId);
         if(_loc25_ != null)
         {
            _loc30_ = "${" + _loc25_.name + "}";
            _loc24_ = "${" + _loc25_.description + "}";
         }
         else
         {
            _loc30_ = "${" + _loc7_.localizationId + "}";
            _loc24_ = "${" + _loc7_.localizationId + "}";
         }
         _productName.caption = _loc30_;
         UnknownVarFromPetPreviewCatalogWidget_IWindowModel_1.caption = _loc24_;
         UnknownVarFromPetPreviewCatalogWidget_IWindowModel_1.y = _productName.y + _productName.height + 5;
         UnknownVarFromPetPreviewCatalogWidget_IWindowModel_2 = _catalog.utils.showPriceOnProduct(param1.offer,_window,UnknownVarFromPetPreviewCatalogWidget_IWindowModel_2,UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1,-6,true,6);
         var _loc20_:Point = new Point(0,0);
         var _loc28_:IRoomEngine = (page.viewer.catalog as HabboCatalog).roomEngine;
         switch(_loc7_.pricingModel)
         {
            case "pricing_model_single":
            case "pricing_model_multi":
               _loc18_ = _loc7_.product;
               _loc11_ = _loc18_.furnitureData;
               if(_loc11_ == null || _loc11_.customParams == null)
               {
                  Logger.log("[Pet Preview Catalog Widget] Unsupported product: " + _loc18_.productType);
                  break;
               }
               _loc21_ = _loc11_.customParams;
               _loc2_ = _loc21_.split(" ");
               if(_loc2_.length < 1)
               {
                  Logger.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                  break;
               }
               _loc29_ = int(_loc2_[0]);
               _loc15_ = [];
               switch(_loc11_.category - 13)
               {
                  case 0:
                     if(_loc2_.length < 2)
                     {
                        Logger.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                        break;
                     }
                     _loc13_ = _loc2_[1];
                     _loc6_ = _loc28_.getPetColorsByTag(_loc29_,_loc13_);
                     for each(var _loc3_ in _loc6_)
                     {
                        if(_loc3_.breed == BREED)
                        {
                           _loc19_ = int(_loc3_.id);
                           break;
                        }
                     }
                     switch(_loc29_ - 15)
                     {
                        case 0:
                           _loc5_ = 2;
                           _loc17_ = 3;
                           _loc10_ = _loc28_.getPetDefaultPalette(_loc29_,"hair");
                           _loc9_ = _loc28_.getPetDefaultPalette(_loc29_,"tail");
                           _loc16_ = !!_loc10_ ? parseInt(_loc10_.id) : -1;
                           _loc27_ = !!_loc9_ ? parseInt(_loc9_.id) : -1;
                           _loc8_ = new PetCustomPart(_loc5_,-1,_loc16_);
                           _loc22_ = new PetCustomPart(_loc17_,-1,_loc27_);
                           _loc15_ = [_loc8_,_loc22_];
                     }
                     _loc4_ = _loc28_.getPetImage(_loc29_,_loc19_,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  case 1:
                     if(_loc2_.length < 4)
                     {
                        Logger.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                        break;
                     }
                     _loc14_ = (_loc2_[1] as String).split(",");
                     _loc26_ = (_loc2_[2] as String).split(",");
                     _loc12_ = (_loc2_[3] as String).split(",");
                     _loc23_ = 0;
                     while(_loc23_ < _loc14_.length)
                     {
                        _loc15_.push(new PetCustomPart(int(_loc14_[_loc23_]),int(_loc26_[_loc23_]),int(_loc12_[_loc23_])));
                        _loc23_++;
                     }
                     _loc4_ = _loc28_.getPetImage(_loc29_,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  case 2:
                     if(_loc2_.length < 3)
                     {
                        Logger.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                        break;
                     }
                     _loc14_ = (_loc2_[1] as String).split(",");
                     _loc12_ = (_loc2_[2] as String).split(",");
                     _loc23_ = 0;
                     while(_loc23_ < _loc14_.length)
                     {
                        _loc15_.push(new PetCustomPart(int(_loc14_[_loc23_]),PART_ID,int(_loc12_[_loc23_])));
                        _loc23_++;
                     }
                     _loc4_ = _loc28_.getPetImage(_loc29_,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  case 3:
                     if(_loc2_.length < 4)
                     {
                        Logger.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                     }
                     _loc15_.push(new PetCustomPart(int(_loc2_[1]),int(_loc2_[2]),int(_loc2_[3])));
                     _loc4_ = _loc28_.getPetImage(_loc29_,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  default:
                     Logger.log("[Pet Preview Catalog Widget] Unsupported Product Type: " + _loc18_.productType);
               }
               if(_loc4_ != null)
               {
                  _loc7_.previewCallbackId = _loc4_.id;
                  _loc31_ = _loc4_.data;
               }
               break;
            default:
               Logger.log("[Pet Preview Catalog Widget] Unknown pricing model" + _loc7_.pricingModel);
         }
         setPreviewImage(_loc31_,true,_loc20_);
         _window.invalidate();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || page == null || page.offers == null)
         {
            return;
         }
         if(UnknownVarFromPetPreviewCatalogWidget_Int_1 == param1)
         {
            setPreviewImage(param2,true);
            UnknownVarFromPetPreviewCatalogWidget_Int_1 = 0;
         }
         else
         {
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
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean, param3:Point = null) : void
      {
         var _loc4_:Point = null;
         if(UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1 != null && !window.disposed)
         {
            if(param1 == null)
            {
               param1 = new BitmapData(1,1);
               param2 = true;
            }
            if(UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.bitmap == null)
            {
               UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.width,UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.height,true,16777215);
            }
            UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.bitmap.rect,16777215);
            _loc4_ = new Point((UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.width - param1.width) / 2,(UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.height - param1.height) / 2);
            UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
            UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.invalidate();
            UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.x = UnknownVarFromPetPreviewCatalogWidget_Point_1.x;
            UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.y = UnknownVarFromPetPreviewCatalogWidget_Point_1.y;
            if(param3 != null)
            {
               UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.x += param3.x;
               UnknownVarFromPetPreviewCatalogWidget_IBitmapWrapperController_1.y += param3.y;
            }
         }
         if(param2)
         {
            param1.dispose();
         }
      }
   }
}

