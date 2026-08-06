package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BreedMonsterPlantsConfirmationView implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private static const STATE_NORMAL:int = 0;
      
      private static const STATE_REQUESTED:int = 1;
      
      private static const ELEM_LIST:String = "element_list";
      
      private static const PREVIEW_LIST:String = "preview_list";
      
      private static const ELEM_PLANT1_ITEMLIST:String = "plant1_itemlist";
      
      private static const ELEM_PLANT2_ITEMLIST:String = "plant2_itemlist";
      
      private static const UnknownConstFromBreedMonsterPlantsConfirmationView_String_1:String = "description";
      
      private static const ELEM_REQUEST:String = "request";
      
      private static const UnknownConstFromBreedMonsterPlantsConfirmationView_String_2:String = "header_button_close";
      
      private static const UnknownConstFromBreedMonsterPlantsConfirmationView_String_3:String = "save_button";
      
      private static const UnknownConstFromBreedMonsterPlantsConfirmationView_String_4:String = "accept_button";
      
      private static const UnknownConstFromBreedMonsterPlantsConfirmationView_String_5:String = "cancel_button";
      
      private static const UnknownConstFromBreedMonsterPlantsConfirmationView_String_6:String = "ok_button";
      
      private static const BUTTON_LIST:String = "button_list";
      
      private var _window:IFrameController;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1:AvatarInfoWidget;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromBreedMonsterPlantsConfirmationView_Map_1:Map;
      
      private var _requestRoomObjectId:int;
      
      private var _targetRoomObjectId:int;
      
      private var UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1:IUserData;
      
      private var _petData2:IUserData;
      
      private var UnknownVarFromBreedMonsterPlantsConfirmationView_Int_1:int = 0;
      
      public function BreedMonsterPlantsConfirmationView(param1:AvatarInfoWidget)
      {
         super();
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1 = param1;
         _windowManager = param1.windowManager;
         _assets = UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.assets;
         UnknownVarFromBreedMonsterPlantsConfirmationView_Map_1 = new Map();
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
         if(UnknownVarFromBreedMonsterPlantsConfirmationView_Map_1 != null)
         {
            UnknownVarFromBreedMonsterPlantsConfirmationView_Map_1.dispose();
         }
         UnknownVarFromBreedMonsterPlantsConfirmationView_Map_1 = null;
      }
      
      public function get requestRoomObjectId() : int
      {
         return _requestRoomObjectId;
      }
      
      public function get targetRoomObjectId() : int
      {
         return _targetRoomObjectId;
      }
      
      public function open(param1:int, param2:int, param3:Boolean) : void
      {
         _requestRoomObjectId = param1;
         _targetRoomObjectId = param2;
         UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1 = UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.handler.roomSession.userDataManager.getUserDataByIndex(param1);
         _petData2 = UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.handler.roomSession.userDataManager.getUserDataByIndex(param2);
         UnknownVarFromBreedMonsterPlantsConfirmationView_Int_1 = param3 ? 1 : 0;
         setWindowContent();
         _window.visible = true;
      }
      
      private function resolvePreviewImage(param1:String, param2:String) : BitmapData
      {
         var _loc7_:BitmapData = null;
         var _loc6_:int = 0;
         var _loc3_:PetFigureData = new PetFigureData(param1);
         var _loc4_:String = "std";
         var _loc5_:UnknownHabboRoom1 = UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.handler.roomEngine.getPetImage(_loc3_.typeId,_loc3_.paletteId,_loc3_.color,new Vector3d(90),64,this,true,0,_loc3_.customParts,_loc4_);
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.id;
            if(_loc6_ > 0)
            {
               UnknownVarFromBreedMonsterPlantsConfirmationView_Map_1.add(_loc6_,param2);
            }
            _loc7_ = _loc5_.data;
         }
         return _loc7_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc3_:String = UnknownVarFromBreedMonsterPlantsConfirmationView_Map_1.getValue(param1);
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
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.title","name",UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1.name);
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.plant1.name","name",UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1.name);
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.plant2.name","name",_petData2.name);
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.plant1.description","name",UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1.ownerName);
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.plant2.description","name",_petData2.ownerName);
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.plant1.raritylevel","level",UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1.rarityLevel.toString());
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.plant2.raritylevel","level",_petData2.rarityLevel.toString());
         UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.localizations.registerParameter("breedpets.widget.request","name",_petData2.ownerName);
         if(!_window)
         {
            _window = _windowManager.buildFromXML(_assets.getAssetByName("breed_pets_confirmation_xml").content as XML) as IFrameController;
            addClickListener("header_button_close");
         }
         _window.center();
         _window.visible = true;
         addClickListener("save_button");
         addClickListener("accept_button");
         addClickListener("cancel_button");
         enableElement("description",false);
         enableElement("request",false);
         enableElement("save_button",false);
         enableElement("save_button",false);
         enableElement("accept_button",false);
         enableElement("cancel_button",true);
         enableElement("cancel_button",true);
         switch(UnknownVarFromBreedMonsterPlantsConfirmationView_Int_1)
         {
            case 0:
               enableElement("description",true);
               enableElement("save_button",true);
               break;
            case 1:
               enableElement("request",true);
               enableElement("accept_button",true);
         }
         var _loc1_:BitmapData = resolvePreviewImage(UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1.figure,"preview_image");
         updatePreviewImage(_loc1_ ?? new BitmapData(10,10),"preview_image");
         _loc1_ = resolvePreviewImage(_petData2.figure,"preview_image2");
         updatePreviewImage(_loc1_ ?? new BitmapData(10,10),"preview_image2");
         arrangeListItems();
         _window.invalidate();
      }
      
      private function arrangeListItems() : void
      {
         arrangeListItem("button_list");
         arrangeListItem("plant1_itemlist");
         arrangeListItem("plant2_itemlist");
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
         var _loc5_:BitmapData = null;
         if(!_window || !param1)
         {
            return;
         }
         var _loc6_:IBitmapWrapperController = _window.findChildByName(param2) as IBitmapWrapperController;
         _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height);
         var _loc3_:ISoundAsset = _assets.getAssetByName("breed_pets_preview_bg_png") as ISoundAsset;
         if(_loc3_)
         {
            _loc5_ = _loc3_.content as BitmapData;
            _loc6_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
         }
         var _loc4_:Point = new Point((_loc6_.width - param1.width) / 2,(_loc6_.height - param1.height) / 2);
         _loc6_.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
      }
      
      private function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         var _loc2_:IWindowModel = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseClick);
         }
      }
      
      private function enableElement(param1:String, param2:Boolean) : void
      {
         var _loc3_:IWindowModel = _window.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.cancelBreedPets(_requestRoomObjectId,_targetRoomObjectId);
               close();
               break;
            case "ok_button":
               close();
               break;
            case "accept_button":
               close();
               UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.acceptBreedPets(_requestRoomObjectId,_targetRoomObjectId);
               break;
            case "save_button":
               UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.breedPets(_requestRoomObjectId,_targetRoomObjectId);
               if(UnknownVarFromBreedMonsterPlantsConfirmationView_IUserData_1.ownerId != _petData2.ownerId)
               {
                  UnknownVarFromBreedMonsterPlantsConfirmationView_AvatarInfoWidget_1.showBreedingPetsWaitingConfirmationAlert(requestRoomObjectId,_targetRoomObjectId);
               }
               close();
         }
      }
   }
}

