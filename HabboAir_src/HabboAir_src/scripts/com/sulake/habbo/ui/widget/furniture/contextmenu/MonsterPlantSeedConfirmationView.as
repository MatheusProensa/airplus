package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class MonsterPlantSeedConfirmationView implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private static const PRODUCT_PAGE_UKNOWN:int = -1;
      
      private static const PRODUCT_PAGE_SEED:int = 0;
      
      private static const UnknownConstFromMonsterPlantSeedConfirmationView_String_1:String = "header_button_close";
      
      private static const UnknownConstFromMonsterPlantSeedConfirmationView_String_2:String = "save_button";
      
      private static const UnknownConstFromMonsterPlantSeedConfirmationView_String_3:String = "cancel_text";
      
      private static const UnknownConstFromMonsterPlantSeedConfirmationView_String_4:String = "ok_button";
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1:FurnitureContextMenuWidget;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromMonsterPlantSeedConfirmationView_Int_1:int = -1;
      
      private var UnknownVarFromMonsterPlantSeedConfirmationView_Int_2:int;
      
      private var UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1:IFurnitureData;
      
      public function MonsterPlantSeedConfirmationView(param1:FurnitureContextMenuWidget)
      {
         super();
         UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1 = param1;
         _windowManager = param1.windowManager;
         _assets = UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.assets;
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
         UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1 = null;
      }
      
      public function open(param1:int) : void
      {
         var _loc3_:int = UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.handler.roomSession.roomId;
         var _loc4_:IRoomObject = UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.handler.roomEngine.getRoomObject(_loc3_,param1,10);
         if(_loc4_ != null)
         {
            UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1 = UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.handler.getFurniData(_loc4_);
            UnknownVarFromMonsterPlantSeedConfirmationView_Int_1 = _loc4_.getId();
         }
         var _loc2_:int = -1;
         switch(UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1.category - 19)
         {
            case 0:
               _loc2_ = 0;
               break;
            default:
               Logger.log("[PlantSeedConfirmationView.open()] Unsupported furniture category: " + UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1.category);
         }
         setWindowContent(_loc2_);
         _window.visible = true;
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc3_:BitmapData = new BitmapData(10,10);
         UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.localizations.registerParameter("useproduct.widget.title.plant_seed","name",UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1.localizedName);
         if(!_window)
         {
            _loc4_ = "use_product_widget_frame_plant_seed_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc4_).content as XML) as IWindowController_1;
            addClickListener("header_button_close");
            _window.center();
         }
         UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.localizations.registerParameter("useproduct.widget.text.plant_seed","productName",UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1.localizedName);
         var _loc2_:IFrameController = _window as IFrameController;
         _loc2_.content.removeChildAt(0);
         var _loc5_:IWindowController_1 = createWindow(param1);
         _loc2_.content.addChild(_loc5_);
         switch(param1)
         {
            case 0:
               addClickListener("save_button");
               addClickListener("cancel_text");
               _loc3_ = resolvePreviewImage(UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1);
               updatePreviewImage(_loc3_);
               _window.invalidate();
               return;
            default:
               throw new Error("Invalid type for use product confirmation content apply: " + param1);
         }
      }
      
      private function createWindow(param1:int) : IWindowController_1
      {
         var _loc2_:ISoundAsset = null;
         var _loc3_:* = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("use_product_controller_plant_seed_xml");
               return _windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
            default:
               throw new Error("Invalid type for view content creation: " + param1);
         }
      }
      
      private function resolvePreviewImage(param1:IFurnitureData) : BitmapData
      {
         var _loc3_:UnknownHabboRoom1 = null;
         var _loc4_:BitmapData = null;
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = param1.customParams.split(" ");
         switch(param1.category - 19)
         {
            case 0:
               _loc3_ = UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.handler.roomEngine.getFurnitureImage(UnknownVarFromMonsterPlantSeedConfirmationView_IFurnitureData_1.id,new Vector3d(90,0,0),64,this,0,"",-1,-1,null);
               break;
            default:
               Logger.log("[PlantSeedConfirmationView] Unsupported furniture category: " + param1.category);
         }
         if(_loc3_ != null)
         {
            UnknownVarFromMonsterPlantSeedConfirmationView_Int_2 = _loc3_.id;
            _loc4_ = _loc3_.data;
         }
         return _loc4_;
      }
      
      private function updatePreviewImage(param1:BitmapData) : void
      {
         if(!_window || !param1)
         {
            return;
         }
         setPreviewImage("preview_image_bg");
         setPreviewImage("preview_image");
      }
      
      private function setPreviewImage(param1:String) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = _window.findChildByName(param1) as IBitmapWrapperController;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:BitmapDataAsset = _assets.getAssetByName(_loc2_.bitmapAssetName) as BitmapDataAsset;
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_.disposesBitmap = false;
         _loc2_.bitmap = _loc3_.content as BitmapData;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:RoomWidgetMessage = null;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               _loc2_ = new RoomWidgetUseProductMessage("RWUPM_MONSTERPLANT_SEED",UnknownVarFromMonsterPlantSeedConfirmationView_Int_1);
               close();
         }
         if(_loc2_)
         {
            UnknownVarFromMonsterPlantSeedConfirmationView_FurnitureContextMenuWidget_1.messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromMonsterPlantSeedConfirmationView_Int_2 == param1)
         {
            updatePreviewImage(param2);
            UnknownVarFromMonsterPlantSeedConfirmationView_Int_2 = 0;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

