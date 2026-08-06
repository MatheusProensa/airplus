package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class NestBreedingSuccessView implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private static const UnknownConstFromNestBreedingSuccessView_String_1:String = "header_button_close";
      
      private static const UnknownConstFromNestBreedingSuccessView_String_2:String = "cancel_button";
      
      private static const UnknownConstFromNestBreedingSuccessView_String_3:String = "button.ok";
      
      private var _window:IFrameController;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromNestBreedingSuccessView_AvatarInfoWidget_1:AvatarInfoWidget;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromNestBreedingSuccessView_IUserData_1:IUserData;
      
      private var UnknownVarFromNestBreedingSuccessView_Int_1:int;
      
      private var UnknownVarFromNestBreedingSuccessView_Map_1:Map;
      
      private var UnknownVarFromNestBreedingSuccessView_Int_2:int;
      
      public function NestBreedingSuccessView(param1:AvatarInfoWidget)
      {
         super();
         UnknownVarFromNestBreedingSuccessView_AvatarInfoWidget_1 = param1;
         _windowManager = param1.windowManager;
         _assets = UnknownVarFromNestBreedingSuccessView_AvatarInfoWidget_1.assets;
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
      }
      
      public function open(param1:int, param2:int) : void
      {
         UnknownVarFromNestBreedingSuccessView_Int_1 = param1;
         UnknownVarFromNestBreedingSuccessView_IUserData_1 = UnknownVarFromNestBreedingSuccessView_AvatarInfoWidget_1.handler.roomSession.userDataManager.getUserDataByIndex(param1);
         if(UnknownVarFromNestBreedingSuccessView_IUserData_1 == null)
         {
            Logger.log("Couldn\'t find the correct pet.");
            return;
         }
         UnknownVarFromNestBreedingSuccessView_Int_2 = param2;
         setWindowContent();
         _window.visible = true;
      }
      
      private function setWindowContent() : void
      {
         if(!_window)
         {
            _window = _windowManager.buildFromXML(_assets.getAssetByName("nestBreedingSuccess_xml").content as XML) as IFrameController;
            addClickListener("header_button_close");
         }
         _window.center();
         _window.visible = true;
         addClickListener("button.ok");
         _window.findChildByName("pet.name").caption = UnknownVarFromNestBreedingSuccessView_IUserData_1.name;
         _window.findChildByName("pet.raritycategory").caption = "${breedpets.nestbreeding.success.raritycategory." + UnknownVarFromNestBreedingSuccessView_Int_2 + "}";
         var _loc1_:BitmapData = resolvePreviewImage(UnknownVarFromNestBreedingSuccessView_IUserData_1.figure,"pet_image");
         updatePreviewImage(_loc1_ ?? new BitmapData(10,10),"pet_image");
         _window.invalidate();
      }
      
      public function close() : void
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
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               close();
               break;
            case "button.ok":
               close();
         }
      }
      
      private function resolvePreviewImage(param1:String, param2:String, param3:int = 64) : BitmapData
      {
         var _loc8_:BitmapData = null;
         var _loc7_:int = 0;
         var _loc4_:PetFigureData = new PetFigureData(param1);
         var _loc5_:String = "std";
         var _loc6_:UnknownHabboRoom1 = UnknownVarFromNestBreedingSuccessView_AvatarInfoWidget_1.handler.roomEngine.getPetImage(_loc4_.typeId,_loc4_.paletteId,_loc4_.color,new Vector3d(90),param3,this,true,0,_loc4_.customParts,_loc5_);
         if(_loc6_ != null)
         {
            _loc7_ = _loc6_.id;
            if(_loc7_ > 0)
            {
               UnknownVarFromNestBreedingSuccessView_Map_1.add(_loc7_,param2);
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
         var _loc3_:String = UnknownVarFromNestBreedingSuccessView_Map_1.getValue(param1);
         if(_loc3_ != null)
         {
            updatePreviewImage(param2,_loc3_);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
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
   }
}

