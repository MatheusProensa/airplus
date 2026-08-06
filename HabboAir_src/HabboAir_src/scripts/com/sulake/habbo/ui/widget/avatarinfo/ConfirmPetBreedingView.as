package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.ui.widget.events.BreedingRarityCategoryData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ConfirmPetBreedingView implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private static const ELEM_LIST:String = "element_list";
      
      private static const PREVIEW_LIST:String = "preview_list";
      
      private static const ELEM_PET1_ITEMLIST:String = "pet1_itemlist";
      
      private static const ELEM_PET2_ITEMLIST:String = "pet2_itemlist";
      
      private static const UnknownConstFromConfirmPetBreedingView_String_1:String = "description";
      
      private static const ELEM_REQUEST:String = "request";
      
      private static const UnknownConstFromConfirmPetBreedingView_String_2:String = "header_button_close";
      
      private static const UnknownConstFromConfirmPetBreedingView_String_3:String = "save_button";
      
      private static const UnknownConstFromConfirmPetBreedingView_String_4:String = "accept_button";
      
      private static const UnknownConstFromConfirmPetBreedingView_String_5:String = "cancel_button";
      
      private static const UnknownConstFromConfirmPetBreedingView_String_6:String = "ok_button";
      
      private static const BUTTON_LIST:String = "button_list";
      
      private var _window:IFrameController;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1:AvatarInfoWidget;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromConfirmPetBreedingView_Map_1:Map;
      
      private var _requestRoomObjectId:int;
      
      private var _targetRoomObjectId:int;
      
      private var UnknownVarFromConfirmPetBreedingView_IUserData_1:IUserData;
      
      private var _petData2:IUserData;
      
      private var UnknownVarFromConfirmPetBreedingView_Boolean_1:Boolean = false;
      
      private var _stuffId:int;
      
      private var _rarityCategories:Array;
      
      private var UnknownVarFromConfirmPetBreedingView_Int_1:int;
      
      public function ConfirmPetBreedingView(param1:AvatarInfoWidget)
      {
         super();
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1 = param1;
         _windowManager = param1.windowManager;
         _assets = UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.assets;
         UnknownVarFromConfirmPetBreedingView_Map_1 = new Map();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromConfirmPetBreedingView_Map_1 != null)
         {
            UnknownVarFromConfirmPetBreedingView_Map_1.dispose();
         }
         UnknownVarFromConfirmPetBreedingView_Map_1 = null;
      }
      
      public function get requestRoomObjectId() : int
      {
         return _requestRoomObjectId;
      }
      
      public function get targetRoomObjectId() : int
      {
         return _targetRoomObjectId;
      }
      
      public function open(param1:int, param2:int, param3:int, param4:Array, param5:int, param6:int, param7:int) : void
      {
         _requestRoomObjectId = param1;
         _targetRoomObjectId = param2;
         UnknownVarFromConfirmPetBreedingView_IUserData_1 = UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.handler.roomSession.userDataManager.getUserDataByIndex(param1);
         _petData2 = UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.handler.roomSession.userDataManager.getUserDataByIndex(param2);
         UnknownVarFromConfirmPetBreedingView_IUserData_1.petLevel = param6;
         _petData2.petLevel = param7;
         _rarityCategories = param4;
         UnknownVarFromConfirmPetBreedingView_Int_1 = param5;
         _stuffId = param3;
         setWindowContent();
         _window.visible = true;
      }
      
      private function resolvePreviewImage(param1:String, param2:String, param3:int = 64) : BitmapData
      {
         var _loc8_:BitmapData = null;
         var _loc7_:int = 0;
         var _loc4_:PetFigureData = new PetFigureData(param1);
         var _loc5_:String = "std";
         var _loc6_:UnknownHabboRoom1 = UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.handler.roomEngine.getPetImage(_loc4_.typeId,_loc4_.paletteId,_loc4_.color,new Vector3d(90),param3,this,true,0,_loc4_.customParts,_loc5_);
         if(_loc6_ != null)
         {
            _loc7_ = _loc6_.id;
            if(_loc7_ > 0)
            {
               UnknownVarFromConfirmPetBreedingView_Map_1.add(_loc7_,param2);
            }
            _loc8_ = _loc6_.data;
         }
         return _loc8_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc3_:String = UnknownVarFromConfirmPetBreedingView_Map_1.getValue(param1);
         if(_loc3_ != null)
         {
            updatePreviewImage(param2,_loc3_);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setWindowContent() : void
      {
         var _loc8_:IItemListWindow = null;
         var _loc1_:PetFigureData = null;
         var _loc5_:IBitmapWrapperController = null;
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.title","name",UnknownVarFromConfirmPetBreedingView_IUserData_1.name);
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.pet1.name","name",UnknownVarFromConfirmPetBreedingView_IUserData_1.name);
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.pet2.name","name",_petData2.name);
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.pet1.description","name",UnknownVarFromConfirmPetBreedingView_IUserData_1.ownerName);
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.pet2.description","name",_petData2.ownerName);
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.pet1.level","level",UnknownVarFromConfirmPetBreedingView_IUserData_1.petLevel.toString());
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.pet2.level","level",_petData2.petLevel.toString());
         UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.request","name",_petData2.ownerName);
         if(!_window)
         {
            _window = _windowManager.buildFromXML(_assets.getAssetByName("confirm_pet_breeding_xml").content as XML) as IFrameController;
            addClickListener("header_button_close");
         }
         _window.center();
         _window.visible = true;
         addClickListener("save_button");
         addClickListener("cancel_button");
         enable();
         var _loc6_:BitmapData = resolvePreviewImage(UnknownVarFromConfirmPetBreedingView_IUserData_1.figure,"preview_image");
         updatePreviewImage(_loc6_ ?? new BitmapData(10,10),"preview_image");
         _loc6_ = resolvePreviewImage(_petData2.figure,"preview_image2");
         updatePreviewImage(_loc6_ ?? new BitmapData(10,10),"preview_image2");
         var _loc4_:IBitmapWrapperController = _windowManager.buildFromXML(_assets.getAssetByName("pet_breeding_pet_preview_xml").content as XML) as IBitmapWrapperController;
         var _loc2_:int = 1;
         for each(var _loc3_ in _rarityCategories)
         {
            UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.confirmation.widget.raritycategory." + _loc2_,"percent",_loc3_.chance.toString());
            _loc8_ = _window.findChildByName("breeds" + _loc2_) as IItemListWindow;
            _loc8_.removeListItems();
            for each(var _loc7_ in _loc3_.breeds)
            {
               _loc1_ = new PetFigureData([UnknownVarFromConfirmPetBreedingView_Int_1,_loc7_].join(" "));
               _loc5_ = _loc4_.clone() as IBitmapWrapperController;
               _loc5_.name = "breed." + _loc7_;
               _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
               if(_loc8_)
               {
                  _loc8_.addListItem(_loc5_);
               }
               _loc6_ = resolvePreviewImage(_loc1_.figureString,_loc5_.name,64);
               updatePreviewImage(_loc6_ ?? new BitmapData(25,25,true,16777215),_loc5_.name);
            }
            _loc2_++;
         }
         arrangeListItems();
         (_window.findChildByName("puppy.name.input") as ITextFieldWindow).setSelection(0,0);
         _window.invalidate();
      }
      
      private function arrangeListItems() : void
      {
         arrangeListItem("button_list");
         arrangeListItem("pet1_itemlist");
         arrangeListItem("pet2_itemlist");
         arrangeListItem("preview_list");
         arrangeListItem("element_list");
         _window.resizeToFitContent();
      }
      
      private function arrangeListItem(param1:String) : void
      {
         var _loc2_:IItemListWindow = _window.findChildByName(param1) as IItemListWindow;
         if(_loc2_ != null)
         {
            _loc2_.arrangeListItems();
         }
      }
      
      private function updatePreviewImage(param1:BitmapData, param2:String) : void
      {
         if(!_window || !param1)
         {
            return;
         }
         var _loc4_:IBitmapWrapperController = _window.findChildByName(param2) as IBitmapWrapperController;
         _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height,true,16777215);
         var _loc3_:Point = new Point((_loc4_.width - param1.width) / 2,(_loc4_.height - param1.height) / 2);
         _loc4_.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function disable() : void
      {
         enableElement("description",false,false);
         enableElement("request",false,false);
         enableElement("cancel_button",false,true);
         enableElement("description",false,true);
         enableElement("save_button",false,true);
      }
      
      public function enable() : void
      {
         enableElement("description",false,false);
         enableElement("request",false,false);
         enableElement("cancel_button",true,true);
         enableElement("description",true,true);
         enableElement("save_button",true,true);
      }
      
      private function addClickListener(param1:String) : void
      {
         var _loc2_:IWindowModel = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseClick);
         }
      }
      
      private function enableElement(param1:String, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:IWindowModel = _window.findChildByName(param1);
         if(_loc4_ != null)
         {
            _loc4_.visible = param3;
            if(param2)
            {
               _loc4_.enable();
            }
            else
            {
               _loc4_.disable();
            }
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = null;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.cancelPetBreeding(_stuffId);
               close();
               break;
            case "ok_button":
               disable();
               break;
            case "save_button":
               _loc2_ = _window.findChildByName("puppy.name.input").caption;
               if(_loc2_.length == 0)
               {
                  _windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.name.required.head}","${breedpets.confirmation.alert.name.required.desc}");
               }
               else
               {
                  UnknownVarFromConfirmPetBreedingView_AvatarInfoWidget_1.confirmPetBreeding(_stuffId,_loc2_,UnknownVarFromConfirmPetBreedingView_IUserData_1.webID,_petData2.webID);
                  disable();
               }
         }
      }
   }
}

