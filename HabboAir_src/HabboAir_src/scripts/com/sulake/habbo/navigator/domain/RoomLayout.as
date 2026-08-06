package com.sulake.habbo.navigator.domain
{
   import com.sulake.core.window.IWindowController_1;
   
   public class RoomLayout
   {
      private var _requiredClubLevel:int;
      
      private var _tileSize:int;
      
      private var _name:String;
      
      private var _view:IWindowController_1;
      
      public function RoomLayout(param1:int, param2:int, param3:String)
      {
         super();
         _requiredClubLevel = param1;
         _tileSize = param2;
         _name = param3;
      }
      
      public function get requiredClubLevel() : int
      {
         return _requiredClubLevel;
      }
      
      public function get tileSize() : int
      {
         return _tileSize;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get view() : IWindowController_1
      {
         return _view;
      }
      
      public function set view(param1:IWindowController_1) : void
      {
         _view = param1;
      }
   }
}

