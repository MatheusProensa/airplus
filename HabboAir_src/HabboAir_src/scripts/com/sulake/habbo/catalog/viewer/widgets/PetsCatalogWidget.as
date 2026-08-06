package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetPalettesEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.SellablePetPaletteData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class PetsCatalogWidget extends CatalogWidget implements ICatalogWidget, UnknownIHabboRoom1
   {
      private var _offers:Map;
      
      private var UnknownVarFromPetsCatalogWidget_Int_1:int = -1;
      
      private var UnknownVarFromPetsCatalogWidget_Int_2:int = 0;
      
      private var UnknownVarFromPetsCatalogWidget_Int_3:int = 0;
      
      private var _selectedProductCode:String;
      
      private var UnknownVarFromPetsCatalogWidget_Boolean_1:Boolean = false;
      
      private var _availablePalettes:Array;
      
      private var _availableColors:Array;
      
      private var UnknownVarFromPetsCatalogWidget_Boolean_2:Boolean = false;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromPetsCatalogWidget_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromPetsCatalogWidget_Int_4:int = -1;
      
      private var UnknownVarFromPetsCatalogWidget_IWindowModel_2:IWindowModel;
      
      public function PetsCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromPetsCatalogWidget_Boolean_2)
         {
            return;
         }
         UnknownVarFromPetsCatalogWidget_Boolean_1 = false;
         _offers.dispose();
         _offers = null;
         _availablePalettes = null;
         _availableColors = null;
         _catalog = null;
         UnknownVarFromPetsCatalogWidget_IWindowModel_1 = null;
         super.dispose();
         UnknownVarFromPetsCatalogWidget_Boolean_2 = true;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         UnknownVarFromPetsCatalogWidget_Boolean_1 = false;
         var _loc2_:IWindowModel = window.findChildByName("ctlg_buy_button");
         UnknownVarFromPetsCatalogWidget_IWindowModel_2 = window.findChildByName("name_input_text");
         if(UnknownVarFromPetsCatalogWidget_IWindowModel_2 == null)
         {
            return false;
         }
         UnknownVarFromPetsCatalogWidget_IWindowModel_2.caption = "";
         _offers = new Map();
         if(page.offers.length == 0)
         {
            return false;
         }
         var _loc1_:UnknownIHabboCatalog1 = page.offers[0];
         UnknownVarFromPetsCatalogWidget_Int_1 = getPetTypeIndexFromProduct(_loc1_.localizationId);
         if(UnknownVarFromPetsCatalogWidget_Int_1 >= 8)
         {
            return false;
         }
         updateAvailablePalettes(_loc1_.localizationId);
         _selectedProductCode = _loc1_.localizationId;
         updateAvailableColors();
         _offers.add(UnknownVarFromPetsCatalogWidget_Int_1,_loc1_);
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("COLOUR_INDEX",onColourIndex);
         events.addEventListener("CWE_APPROVE_RESULT",onApproveNameResult);
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         events.addEventListener("SELLABLE_PET_PALETTES",onSellablePetPalettes);
         return true;
      }
      
      private function updateAvailableColors() : void
      {
         _availableColors = [];
         if(UnknownVarFromPetsCatalogWidget_Int_1 == 0)
         {
            _availableColors = [16743226,16750435,16764339,16094464,16498012,16704690,15586304,16115545,16513201,8694111,11585939,14413767,6664599,9553845,12971486,8358322,10002885,13292268,10780600,12623573,14403561,12418717,14327229,15517403,14515069,15764368,16366271,11250603,13948116,16777215,14256481,14656129,15848130,14005087,14337152,15918540,15118118,15531929,9764857,11258085];
         }
         else if(UnknownVarFromPetsCatalogWidget_Int_1 == 1)
         {
            _availableColors = [16743226,16750435,16764339,16094464,16498012,16704690,15586304,16115545,16513201,8694111,11585939,14413767,6664599,9553845,12971486,8358322,10002885,13292268,10780600,12623573,14403561,12418717,14327229,15517403,14515069,15764368,16366271,11250603,13948116,16777215,14256481,14656129,15848130,14005087,14337152,15918540,15118118,15531929,9764857,11258085];
         }
         else if(UnknownVarFromPetsCatalogWidget_Int_1 == 2)
         {
            _availableColors = [16579283,15378351,8830016,15257125,9340985,8949607,6198292,8703620,9889626,8972045,12161285,13162269,8620113,12616503,8628101,13827840,9764857];
         }
         else if(UnknownVarFromPetsCatalogWidget_Int_1 == 3)
         {
            _availableColors = [16777215,15658734,14540253];
         }
         else if(UnknownVarFromPetsCatalogWidget_Int_1 == 4)
         {
            _availableColors = [16777215,16053490,15464440,16248792,15396319,15007487];
         }
         else if(UnknownVarFromPetsCatalogWidget_Int_1 == 5)
         {
            _availableColors = [16777215,15658734,14540253];
         }
         else if(UnknownVarFromPetsCatalogWidget_Int_1 == 6)
         {
            _availableColors = [16777215,15658734,14540253,16767177,16770205,16751331];
         }
         else if(UnknownVarFromPetsCatalogWidget_Int_1 == 7)
         {
            _availableColors = [13421772,11447982,16751331,10149119,16763290,16743786];
         }
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent = null) : void
      {
         if(UnknownVarFromPetsCatalogWidget_Boolean_2)
         {
            return;
         }
         events.dispatchEvent(new CatalogWidgetPurchaseOverrideEvent(onPurchase));
         var _loc2_:Offer = _offers.getWithIndex(0);
         if(_loc2_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc2_));
         }
         var _loc4_:Array = [];
         for each(var _loc3_ in _availableColors)
         {
            _loc4_.push(_loc3_);
         }
         events.dispatchEvent(new CatalogWidgetColoursEvent(_loc4_,"ctlg_clr_27x22_1","ctlg_clr_27x22_2","ctlg_clr_27x22_3"));
      }
      
      private function onPurchase(param1:WindowEvent) : void
      {
         if(UnknownVarFromPetsCatalogWidget_Boolean_1)
         {
            Logger.log("* Cannot buy a pet, pending previous name approval.");
         }
         if(getPurchaseParameters() == "")
         {
            return;
         }
         UnknownVarFromPetsCatalogWidget_Boolean_1 = true;
         _catalog.approveName(UnknownVarFromPetsCatalogWidget_IWindowModel_2.caption,1);
      }
      
      public function onDropMenuEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WE_SELECTED")
         {
            _loc3_ = int(IDropBaseController_1(param2).selection);
            if(_availablePalettes == null || _loc3_ >= _availablePalettes.length)
            {
               return;
            }
            UnknownVarFromPetsCatalogWidget_Int_2 = _loc3_;
            updateImage();
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         updateImage();
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromPetsCatalogWidget_Int_3 = param1.index;
         if(UnknownVarFromPetsCatalogWidget_Int_3 < 0 || UnknownVarFromPetsCatalogWidget_Int_3 > _availableColors.length)
         {
            UnknownVarFromPetsCatalogWidget_Int_3 = 0;
         }
         updateImage();
      }
      
      private function onApproveNameResult(param1:CatalogWidgetApproveNameResultEvent) : void
      {
         var nameValidationInfo:String;
         var extraParameter:String;
         var event:CatalogWidgetApproveNameResultEvent = param1;
         if(event == null || !UnknownVarFromPetsCatalogWidget_Boolean_1)
         {
            return;
         }
         UnknownVarFromPetsCatalogWidget_Boolean_1 = false;
         nameValidationInfo = event.nameValidationInfo;
         if(event.result != 0)
         {
            _catalog.purchaseWillBeGift(false);
         }
         switch(event.result - 1)
         {
            case 0:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("long",nameValidationInfo),0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               return;
            case 1:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("short",nameValidationInfo),0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               return;
            case 2:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("chars",nameValidationInfo),0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               return;
            case 3:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("bobba",nameValidationInfo),0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               return;
            default:
               extraParameter = getPurchaseParameters();
               if(extraParameter == "")
               {
                  Logger.log("* Not enough information to buy a pet!");
                  return;
               }
               Logger.log("* Will buy pet as " + extraParameter);
               _catalog.showPurchaseConfirmation(_offers.getWithIndex(0),page.pageId,extraParameter,1,null,null,true,getPetImage());
               return;
         }
      }
      
      private function constructErrorMessage(param1:String, param2:String) : String
      {
         var _loc4_:IHabboLocalizationManager = _catalog.localization;
         var _loc3_:String = "catalog.alert.petname." + param1;
         var _loc6_:String = _loc3_ + ".additionalInfo";
         _loc4_.registerParameter(_loc6_,"additional_info",param2);
         var _loc7_:* = _loc4_.getLocalization(_loc3_);
         var _loc5_:String = _loc4_.getLocalization(_loc6_);
         if(param2 != null && param2.length > 0 && _loc5_ != null && _loc5_.length > 0)
         {
            _loc7_ = _loc5_;
         }
         return _loc7_;
      }
      
      private function onSellablePetPalettes(param1:CatalogWidgetSellablePetPalettesEvent) : void
      {
         if(param1.productCode == _selectedProductCode)
         {
            _availablePalettes = parseSellablePalettes(param1.sellablePalettes);
            UnknownVarFromPetsCatalogWidget_Int_2 = 0;
            updatePaletteSelections();
         }
      }
      
      private function parseSellablePalettes(param1:Array) : Array
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            if(_loc3_.type == UnknownVarFromPetsCatalogWidget_Int_1 && _loc3_.sellable)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function updatePaletteSelections() : void
      {
         var _loc4_:int = 0;
         var _loc3_:SellablePetPaletteData = null;
         var _loc1_:IHabboLocalizationManager = _catalog.localization;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _availablePalettes.length)
         {
            _loc3_ = _availablePalettes[_loc4_] as SellablePetPaletteData;
            _loc2_.push(_loc1_.getLocalization(getRaceLocalizationKey(UnknownVarFromPetsCatalogWidget_Int_1,_loc3_.breedId),getRaceLocalizationKey(UnknownVarFromPetsCatalogWidget_Int_1,_loc3_.breedId)));
            _loc4_++;
         }
         var _loc5_:IDropBaseController_1 = window.findChildByName("type_drop_menu") as IDropBaseController_1;
         if(_loc5_ == null)
         {
            return;
         }
         if(_loc2_.length > 1)
         {
            _loc5_.populate(_loc2_);
            _loc5_.selection = 0;
            _loc5_.procedure = onDropMenuEvent;
            _loc5_.visible = true;
         }
         else
         {
            _loc5_.visible = false;
         }
         updateImage();
      }
      
      private function getPetImage() : BitmapData
      {
         var _loc1_:Offer = _offers.getWithIndex(0);
         if(_loc1_ == null)
         {
            return null;
         }
         if(_availablePalettes == null || UnknownVarFromPetsCatalogWidget_Int_2 >= _availablePalettes.length)
         {
            return null;
         }
         var _loc2_:* = 16777215;
         if(UnknownVarFromPetsCatalogWidget_Int_3 >= 0 && UnknownVarFromPetsCatalogWidget_Int_3 < _availableColors.length)
         {
            _loc2_ = uint(_availableColors[UnknownVarFromPetsCatalogWidget_Int_3]);
         }
         var _loc4_:int = UnknownVarFromPetsCatalogWidget_Int_1;
         var _loc3_:SellablePetPaletteData = _availablePalettes[UnknownVarFromPetsCatalogWidget_Int_2] as SellablePetPaletteData;
         var _loc5_:int = _loc3_.paletteId;
         var _loc6_:UnknownHabboRoom1 = _catalog.roomEngine.getPetImage(_loc4_,_loc5_,_loc2_,new Vector3d(90,0,0),64,this);
         if(_loc6_ != null)
         {
            UnknownVarFromPetsCatalogWidget_Int_4 = _loc6_.id;
            return _loc6_.data;
         }
         return null;
      }
      
      private function updateImage() : void
      {
         var _loc1_:Offer = _offers.getWithIndex(0);
         if(_loc1_ == null || UnknownVarFromPetsCatalogWidget_Int_2 < 0)
         {
            return;
         }
         var _loc2_:BitmapData = getPetImage();
         if(_loc2_ != null)
         {
            setPreviewImage(_loc2_,true);
         }
         var _loc3_:IWindowModel = window.findChildByName("ctlg_teaserimg_1");
         UnknownVarFromPetsCatalogWidget_IWindowModel_1 = _catalog.utils.showPriceOnProduct(_loc1_,_window,UnknownVarFromPetsCatalogWidget_IWindowModel_1,_loc3_,-6,false,6);
      }
      
      private function getPurchaseParameters() : String
      {
         var color:uint;
         var data:SellablePetPaletteData;
         var paletteId:int;
         var p:String;
         var name:String = UnknownVarFromPetsCatalogWidget_IWindowModel_2.caption;
         if(name == null || name.length == 0)
         {
            _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}","${catalog.alert.petname.empty}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
            return "";
         }
         if(_availablePalettes == null || UnknownVarFromPetsCatalogWidget_Int_2 >= _availablePalettes.length)
         {
            return "";
         }
         if(UnknownVarFromPetsCatalogWidget_Int_3 >= _availableColors.length)
         {
            return "";
         }
         color = uint(_availableColors[UnknownVarFromPetsCatalogWidget_Int_3]);
         data = _availablePalettes[UnknownVarFromPetsCatalogWidget_Int_2] as SellablePetPaletteData;
         paletteId = data.paletteId;
         p = name + String.fromCharCode(10) + paletteId + String.fromCharCode(10) + addZeroPadding(color.toString(16).toUpperCase(),6);
         return p;
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc6_:IBitmapWrapperController = null;
         var _loc5_:int = 0;
         var _loc3_:BitmapData = null;
         var _loc4_:Point = null;
         if(!window.disposed)
         {
            if(param1 == null)
            {
               param1 = new BitmapData(1,1);
               param2 = true;
            }
            _loc6_ = window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperController;
            if(_loc6_ != null)
            {
               if(_loc6_.bitmap == null)
               {
                  _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
               }
               _loc6_.bitmap.fillRect(_loc6_.bitmap.rect,16777215);
               _loc5_ = 2;
               _loc3_ = new BitmapData(param1.width * _loc5_,param1.height * _loc5_,true,16777215);
               _loc3_.draw(param1,new Matrix(_loc5_,0,0,_loc5_));
               _loc4_ = new Point((_loc6_.width - _loc3_.width) / 2,(_loc6_.height - _loc3_.height) / 2);
               _loc6_.bitmap.copyPixels(_loc3_,_loc3_.rect,_loc4_,null,null,true);
               _loc6_.invalidate();
               _loc3_.dispose();
            }
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function getPetTypeIndexFromProduct(param1:String) : int
      {
         if(param1.length == 0)
         {
            return 0;
         }
         var _loc2_:int = 0;
         _loc2_ = param1.length - 1;
         while(_loc2_ >= 0)
         {
            if(isNaN(parseInt(param1.charAt(_loc2_))))
            {
               break;
            }
            _loc2_--;
         }
         if(_loc2_ > 0)
         {
            return int(param1.substring(_loc2_ + 1));
         }
         return -1;
      }
      
      private function getRaceLocalizationKey(param1:int, param2:int) : String
      {
         return "pet.breed." + param1 + "." + param2;
      }
      
      private function addZeroPadding(param1:String, param2:int) : String
      {
         while(param1.length < param2)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      private function updateAvailablePalettes(param1:String) : void
      {
         var _loc2_:Array = null;
         if(_availablePalettes == null)
         {
            _loc2_ = _catalog.getSellablePetPalettes(param1);
            _availablePalettes = parseSellablePalettes(_loc2_);
            UnknownVarFromPetsCatalogWidget_Int_2 = 0;
            if(_availablePalettes != null)
            {
               updatePaletteSelections();
            }
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 == UnknownVarFromPetsCatalogWidget_Int_4)
         {
            setPreviewImage(param2,true);
            onWidgetsInitialized();
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

