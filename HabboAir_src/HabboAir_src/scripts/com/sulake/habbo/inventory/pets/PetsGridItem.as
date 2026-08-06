package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PetsGridItem
   {
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var _pet:PetData;
      
      private var _window:IWindowController_1;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromPetsGridItem_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromPetsGridItem_Boolean_1:Boolean;
      
      private var UnknownVarFromPetsGridItem_PetsView_1:PetsView;
      
      private var _imageDownloadId:int = -1;
      
      private var UnknownVarFromPetsGridItem_Boolean_2:Boolean;
      
      private var _isUnseen:Boolean;
      
      public function PetsGridItem(param1:PetsView, param2:PetData, param3:IHabboWindowManagerComponent, param4:IAssetLibraryCollection, param5:Boolean)
      {
         super();
         if(param1 == null || param2 == null || param3 == null || param4 == null)
         {
            return;
         }
         _assets = param4;
         UnknownVarFromPetsGridItem_PetsView_1 = param1;
         _pet = param2;
         _isUnseen = param5;
         var _loc8_:XmlAsset = param4.getAssetByName("inventory_thumb_xml") as XmlAsset;
         if(_loc8_ == null || _loc8_.content == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc8_.content as XML) as IWindowController_1;
         _window.procedure = eventHandler;
         var _loc7_:int = 64;
         var _loc11_:int = 3;
         var _loc9_:Boolean = false;
         var _loc6_:String = null;
         if(param2.typeId == 15)
         {
            _loc7_ = 32;
            _loc11_ = 2;
            _loc9_ = true;
         }
         else if(param2.typeId == 35)
         {
            _loc7_ = 64;
            _loc11_ = 3;
            _loc9_ = true;
         }
         else if(param2.typeId == 26 || param2.typeId == 27)
         {
            _loc7_ = 32;
            _loc11_ = 3;
            _loc9_ = true;
         }
         else if(param2.typeId == 16)
         {
            _loc7_ = 32;
            _loc11_ = 2;
            _loc9_ = true;
            if(param2.level >= 7)
            {
               _loc6_ = "std";
            }
            else
            {
               _loc6_ = "grw" + param2.level;
            }
         }
         var _loc10_:BitmapData = param1.getPetImage(param2,_loc11_,_loc9_,this,_loc7_,_loc6_);
         setPetImage(_loc10_);
         updateRarityOverlay();
         updateStatusGraphics();
      }
      
      public function dispose() : void
      {
         _assets = null;
         UnknownVarFromPetsGridItem_PetsView_1 = null;
         _pet = null;
         UnknownVarFromPetsGridItem_IWindowModel_1 = null;
         _imageDownloadId = -1;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         switch(param1.type)
         {
            case "WME_DOWN":
               UnknownVarFromPetsGridItem_PetsView_1.setSelectedGridItem(this);
               UnknownVarFromPetsGridItem_Boolean_2 = true;
               break;
            case "WME_UP":
               UnknownVarFromPetsGridItem_Boolean_2 = false;
               break;
            case "WME_OUT":
               if(UnknownVarFromPetsGridItem_Boolean_2)
               {
                  UnknownVarFromPetsGridItem_Boolean_2 = false;
                  UnknownVarFromPetsGridItem_PetsView_1.placePetToRoom(_pet.id,true);
               }
         }
      }
      
      public function setPetImage(param1:BitmapData) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _window.findChildByName("bitmap") as IBitmapWrapperController;
         var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height);
         _loc2_.fillRect(_loc2_.rect,0);
         _loc2_.copyPixels(param1,param1.rect,new Point(_loc2_.width / 2 - param1.width / 2,_loc2_.height / 2 - param1.height / 2));
         if(_loc3_.bitmap)
         {
            _loc3_.bitmap.dispose();
         }
         _loc3_.bitmap = _loc2_;
      }
      
      public function setUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            updateStatusGraphics();
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(UnknownVarFromPetsGridItem_Boolean_1 != param1)
         {
            UnknownVarFromPetsGridItem_Boolean_1 = param1;
            if(!_window || !UnknownVarFromPetsGridItem_IWindowModel_1)
            {
               return;
            }
            updateStatusGraphics();
         }
      }
      
      private function updateStatusGraphics() : void
      {
         var _loc1_:IWindowModel = _window.findChildByName("outline");
         if(_loc1_ != null)
         {
            _loc1_.visible = UnknownVarFromPetsGridItem_Boolean_1;
         }
         if(!UnknownVarFromPetsGridItem_IWindowModel_1)
         {
            UnknownVarFromPetsGridItem_IWindowModel_1 = _window.findChildByTag("BG_COLOR");
         }
         UnknownVarFromPetsGridItem_IWindowModel_1.color = _isUnseen ? 10275685 : 13421772;
      }
      
      private function updateRarityOverlay() : void
      {
         var _loc1_:IRarityItemGridOverlayWidget = null;
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWidgetWindowController = _window.findChildByName("rarity_item_overlay_container") as IWidgetWindowController;
         if(_loc2_ == null)
         {
            return;
         }
         if(_pet != null && _pet.rarityLevel >= 0)
         {
            _loc1_ = IRarityItemGridOverlayWidget(_loc2_.widget);
            _loc1_.rarityLevel = _pet.rarityLevel;
            _loc2_.visible = true;
         }
         else
         {
            _loc2_.visible = false;
         }
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      public function get pet() : PetData
      {
         return _pet;
      }
      
      public function set imageDownloadId(param1:int) : void
      {
         _imageDownloadId = param1;
      }
      
      public function get imageDownloadId() : int
      {
         return _imageDownloadId;
      }
   }
}

