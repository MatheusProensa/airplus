package com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IPetImageWidget;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class VariableHolderPreviewer implements UnknownIHabboRoom1, IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromVariableHolderPreviewer_Number_1:Number;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromVariableHolderPreviewer_WiredMenuController_1:WiredMenuController;
      
      private var UnknownVarFromVariableHolderPreviewer_Int_1:int = 0;
      
      private var UnknownVarFromVariableHolderPreviewer_Int_2:int = -1;
      
      public function VariableHolderPreviewer(param1:IWindowController_1, param2:WiredMenuController)
      {
         super();
         _container = param1;
         UnknownVarFromVariableHolderPreviewer_WiredMenuController_1 = param2;
         clearPreviewer();
      }
      
      public static function centerContainer(param1:IWindowModel) : void
      {
         param1.x = param1.parent.width / 2 - param1.width / 2;
         param1.y = param1.parent.height / 2 - param1.height / 2;
      }
      
      public function clearPreviewer() : void
      {
         UnknownVarFromVariableHolderPreviewer_Int_1 = 0;
         UnknownVarFromVariableHolderPreviewer_Int_2 = -1;
         previewFurniInstructionText.visible = false;
         previewUserInstructionText.visible = false;
         previewAvatarWidget.visible = false;
         previewPetWidget.visible = false;
         previewImageBitmap.visible = false;
         previewGlobalPlaceholder.visible = false;
      }
      
      public function setFurniInstructions() : void
      {
         clearPreviewer();
         previewFurniInstructionText.visible = true;
      }
      
      public function setUserInstructions() : void
      {
         clearPreviewer();
         previewUserInstructionText.visible = true;
      }
      
      public function setPreviewByUserIndex(param1:int) : void
      {
         var _loc4_:IPetImageWidget = null;
         var _loc3_:IAvatarImageWidget = null;
         if(param1 == UnknownVarFromVariableHolderPreviewer_Int_2)
         {
            return;
         }
         clearPreviewer();
         var _loc2_:IUserData = UnknownVarFromVariableHolderPreviewer_WiredMenuController_1.roomEvents.roomSession.userDataManager.getUserDataByIndex(param1);
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.type - 1)
         {
            case 0:
            case 2:
            case 3:
               previewAvatarWidget.visible = true;
               _loc3_ = previewAvatarWidget.widget as IAvatarImageWidget;
               _loc3_.figure = _loc2_.figure;
               centerContainer(previewAvatarWidget);
               break;
            case 1:
               previewPetWidget.visible = true;
               _loc4_ = previewPetWidget.widget as IPetImageWidget;
               _loc4_.figure = _loc2_.figure;
               centerContainer(previewPetWidget);
         }
         UnknownVarFromVariableHolderPreviewer_Int_2 = param1;
      }
      
      public function setFurniByObjectId(param1:int) : void
      {
         var _loc4_:int = 0;
         if(param1 == UnknownVarFromVariableHolderPreviewer_Int_1 || -param1 == UnknownVarFromVariableHolderPreviewer_Int_1)
         {
            return;
         }
         clearPreviewer();
         if(param1 >= 0)
         {
            _loc4_ = 10;
         }
         else
         {
            param1 = -param1;
            _loc4_ = 20;
         }
         var _loc3_:IRoomEngine = UnknownVarFromVariableHolderPreviewer_WiredMenuController_1.roomEngine;
         var _loc2_:UnknownHabboRoom1 = _loc3_.getRoomObjectImage(_loc3_.activeRoomId,param1,_loc4_,new Vector3d(180),64,null);
         if(_loc2_.data != null)
         {
            previewImageBitmap.bitmap = _loc2_.data.clone();
            if(_loc2_.data.width >= _container.width - 6 || _loc2_.data.height > _container.height - 6)
            {
               (previewImageBitmap as UnknownICoreWindowUtils4).zoomX = 0.5;
               (previewImageBitmap as UnknownICoreWindowUtils4).zoomY = 0.5;
            }
            else
            {
               (previewImageBitmap as UnknownICoreWindowUtils4).zoomX = 1;
               (previewImageBitmap as UnknownICoreWindowUtils4).zoomY = 1;
            }
            previewImageBitmap.visible = true;
            centerContainer(previewImageBitmap);
         }
         UnknownVarFromVariableHolderPreviewer_Int_1 = param1;
      }
      
      public function setGlobalPlaceholder() : void
      {
         clearPreviewer();
         previewGlobalPlaceholder.visible = true;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
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
         UnknownVarFromVariableHolderPreviewer_Number_1 = -1;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get previewFurniInstructionText() : ITextWindow
      {
         return _container.findChildByName("preview_instruction_furni") as ITextWindow;
      }
      
      private function get previewUserInstructionText() : ITextWindow
      {
         return _container.findChildByName("preview_instruction_user") as ITextWindow;
      }
      
      private function get previewAvatarWidget() : IWidgetWindowController
      {
         return _container.findChildByName("preview_avatar") as IWidgetWindowController;
      }
      
      private function get previewPetWidget() : IWidgetWindowController
      {
         return _container.findChildByName("preview_pet") as IWidgetWindowController;
      }
      
      private function get previewImageBitmap() : IBitmapWrapperController
      {
         return _container.findChildByName("preview_image_bitmap") as IBitmapWrapperController;
      }
      
      private function get previewGlobalPlaceholder() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("global_placeholder") as IStaticBitmapWrapperWindow;
      }
   }
}

