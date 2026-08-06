package com.sulake.habbo.roomevents.wired_menu.variables_management.detail
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IPetImageWidget;
   import flash.display.BitmapData;
   
   public class PermanentVariableHolderPreviewer implements UnknownIHabboRoom1, IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromPermanentVariableHolderPreviewer_WiredMenuController_1:WiredMenuController;
      
      private var UnknownVarFromPermanentVariableHolderPreviewer_Int_1:int;
      
      public function PermanentVariableHolderPreviewer(param1:IWindowController_1, param2:WiredMenuController)
      {
         super();
         _container = param1;
         UnknownVarFromPermanentVariableHolderPreviewer_WiredMenuController_1 = param2;
         clearPreviewer();
         previewAvatarRegion.addEventListener("WME_CLICK",onPreviewAvatarClicked);
      }
      
      public static function centerContainer(param1:IWindowModel) : void
      {
         param1.x = param1.parent.width / 2 - param1.width / 2;
         param1.y = param1.parent.height / 2 - param1.height / 2;
      }
      
      private function onPreviewAvatarClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromPermanentVariableHolderPreviewer_WiredMenuController_1.send(new GetExtendedProfileMessageComposer(UnknownVarFromPermanentVariableHolderPreviewer_Int_1,true));
      }
      
      public function clearPreviewer() : void
      {
         previewAvatarWidget.visible = false;
         previewPetWidget.visible = false;
      }
      
      public function setPetPreview(param1:String) : void
      {
         clearPreviewer();
         previewPetWidget.visible = true;
         var _loc2_:IPetImageWidget = previewPetWidget.widget as IPetImageWidget;
         _loc2_.figure = param1;
         centerContainer(previewPetWidget);
      }
      
      public function setUserPreview(param1:String, param2:int = -1) : void
      {
         clearPreviewer();
         previewAvatarWidget.visible = true;
         var _loc3_:IAvatarImageWidget = previewAvatarWidget.widget as IAvatarImageWidget;
         _loc3_.figure = param1;
         centerContainer(previewAvatarWidget);
         UnknownVarFromPermanentVariableHolderPreviewer_Int_1 = param2;
         previewAvatarRegion.visible = param2 != -1;
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
         UnknownVarFromPermanentVariableHolderPreviewer_Int_1 = -1;
         _container = null;
         UnknownVarFromPermanentVariableHolderPreviewer_WiredMenuController_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get previewAvatarWidget() : IWidgetWindowController
      {
         return _container.findChildByName("avatar_preview") as IWidgetWindowController;
      }
      
      private function get previewAvatarRegion() : IRegionWindow
      {
         return _container.findChildByName("avatar_preview_region") as IRegionWindow;
      }
      
      private function get previewPetWidget() : IWidgetWindowController
      {
         return _container.findChildByName("pet_preview") as IWidgetWindowController;
      }
   }
}

