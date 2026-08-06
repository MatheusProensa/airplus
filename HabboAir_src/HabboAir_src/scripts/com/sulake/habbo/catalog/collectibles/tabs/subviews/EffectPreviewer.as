package com.sulake.habbo.catalog.collectibles.tabs.subviews
{
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   
   public class EffectPreviewer implements UnknownIHabboAvatar1
   {
      private static var UnknownVarFromEffectPreviewer_Int_1:int = 2;
      
      private var UnknownVarFromEffectPreviewer_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _disposed:Boolean;
      
      public function EffectPreviewer(param1:IWidgetWindowController, param2:IAvatarRenderManager)
      {
         super();
         UnknownVarFromEffectPreviewer_IWidgetWindowController_1 = param1;
         _avatarRenderManager = param2;
         roomPreviewer.updateRoomWallsAndFloorVisibility(false,false);
      }
      
      public function update(param1:String, param2:int) : void
      {
         var _loc3_:IAvatarImage_2 = null;
         var _loc4_:RoomPreviewer = roomPreviewer;
         if(_loc4_.isRoomEngineReady)
         {
            _loc4_.addAvatarIntoRoom(param1,param2);
            _loc4_.updateAvatarDirectionAndLocation(UnknownVarFromEffectPreviewer_Int_1,UnknownVarFromEffectPreviewer_Int_1);
            _loc4_.updatePreviewRoomView(true);
            _loc4_.updateRoomEngine();
         }
         else
         {
            _loc3_ = _avatarRenderManager.createAvatarImage(param1,"h",null,this);
            widget.showPreview(_loc3_.getCroppedImage("full"));
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:IAvatarImage_2 = null;
         if(!_disposed)
         {
            _loc2_ = _avatarRenderManager.createAvatarImage(param1,"h",null,this);
            widget.showPreview(_loc2_.getCroppedImage("full"));
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         roomPreviewer.reset(true);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get widget() : IRoomPreviewerWidget
      {
         return UnknownVarFromEffectPreviewer_IWidgetWindowController_1.widget as IRoomPreviewerWidget;
      }
      
      private function get roomPreviewer() : RoomPreviewer
      {
         return widget.roomPreviewer;
      }
      
      public function set visible(param1:Boolean) : void
      {
         UnknownVarFromEffectPreviewer_IWidgetWindowController_1.visible = param1;
      }
   }
}

