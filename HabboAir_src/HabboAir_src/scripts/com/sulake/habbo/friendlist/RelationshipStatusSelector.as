package com.sulake.habbo.friendlist
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Point;
   
   public class RelationshipStatusSelector implements IComponentInterfaceQueue
   {
      private var _friendList:HabboFriendList;
      
      private var _window:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromRelationshipStatusSelector_Int_1:int;
      
      private var _disposed:Boolean = false;
      
      public function RelationshipStatusSelector(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            destroyWindow();
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function appearAt(param1:IWindowModel, param2:IWindowModel) : void
      {
         var _loc3_:Point = new Point();
         param1.getGlobalPosition(_loc3_);
         _window.x = _loc3_.x;
         _window.y = _loc3_.y;
         _window.visible = true;
         _window.activate();
      }
      
      public function disappear() : void
      {
         _window.visible = false;
      }
      
      public function set friendId(param1:int) : void
      {
         UnknownVarFromRelationshipStatusSelector_Int_1 = param1;
      }
      
      private function createWindow() : void
      {
         _window = UnknownICoreWindowComponents6(_friendList.windowManager.buildFromXML(XML(_friendList.assets.getAssetByName("relationship_chooser_xml").content)));
         _window.procedure = onWindowEvent;
         _window.visible = false;
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "item_none":
                  _friendList.setRelationshipStatus(UnknownVarFromRelationshipStatusSelector_Int_1,0);
                  break;
               case "item_heart":
                  _friendList.setRelationshipStatus(UnknownVarFromRelationshipStatusSelector_Int_1,1);
                  break;
               case "item_smile":
                  _friendList.setRelationshipStatus(UnknownVarFromRelationshipStatusSelector_Int_1,2);
                  break;
               case "item_bobba":
                  _friendList.setRelationshipStatus(UnknownVarFromRelationshipStatusSelector_Int_1,3);
            }
            _window.visible = false;
         }
         if(param1.type == "WE_UNFOCUSED")
         {
            _window.visible = false;
         }
      }
   }
}

