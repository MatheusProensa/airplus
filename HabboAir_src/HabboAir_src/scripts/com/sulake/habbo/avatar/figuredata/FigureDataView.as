package com.sulake.habbo.avatar.figuredata
{
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   
   public class FigureDataView implements UnknownIHabboAvatar1
   {
      public static const PREVIEW_AVATAR_DIRECTION:int = 4;
      
      private var UnknownVarFromFigureDataView_IRoomPreviewerWidget_1:IRoomPreviewerWidget;
      
      private var UnknownVarFromFigureDataView_RoomPreviewer_1:RoomPreviewer;
      
      private var UnknownVarFromFigureDataView_FigureData_1:FigureData;
      
      private var _figureString:String;
      
      private var _disposed:Boolean;
      
      public function FigureDataView(param1:FigureData)
      {
         super();
         UnknownVarFromFigureDataView_FigureData_1 = param1;
         UnknownVarFromFigureDataView_IRoomPreviewerWidget_1 = param1.avatarEditor.view.getFigureContainer().widget as IRoomPreviewerWidget;
         UnknownVarFromFigureDataView_RoomPreviewer_1 = UnknownVarFromFigureDataView_IRoomPreviewerWidget_1.roomPreviewer;
         UnknownVarFromFigureDataView_RoomPreviewer_1.updateRoomWallsAndFloorVisibility(false,false);
      }
      
      public function update(param1:String, param2:int = 0, param3:int = 4) : void
      {
         var _loc4_:IAvatarImage_2 = null;
         _figureString = param1;
         if(UnknownVarFromFigureDataView_RoomPreviewer_1.isRoomEngineReady)
         {
            UnknownVarFromFigureDataView_RoomPreviewer_1.addAvatarIntoRoom(param1,param2);
            UnknownVarFromFigureDataView_RoomPreviewer_1.updateAvatarDirectionAndLocation(param3,param3);
            UnknownVarFromFigureDataView_RoomPreviewer_1.updatePreviewRoomView(true);
            UnknownVarFromFigureDataView_RoomPreviewer_1.updateRoomEngine();
         }
         else
         {
            _loc4_ = UnknownVarFromFigureDataView_FigureData_1.avatarEditor.manager.avatarRenderManager.createAvatarImage(param1,"h",null,this);
            UnknownVarFromFigureDataView_IRoomPreviewerWidget_1.showPreview(_loc4_.getCroppedImage("full"));
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:IAvatarImage_2 = null;
         if(param1 == _figureString)
         {
            _loc2_ = UnknownVarFromFigureDataView_FigureData_1.avatarEditor.manager.avatarRenderManager.createAvatarImage(param1,"h",null,this);
            UnknownVarFromFigureDataView_IRoomPreviewerWidget_1.showPreview(_loc2_.getCroppedImage("full"));
         }
      }
      
      public function dispose() : void
      {
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

