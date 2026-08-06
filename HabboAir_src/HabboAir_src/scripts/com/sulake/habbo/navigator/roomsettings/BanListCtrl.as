package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.IHabboNavigator_2;
   
   public class BanListCtrl extends UserListCtrl
   {
      private var _selectedRow:int = -1;
      
      public function BanListCtrl(param1:IHabboNavigator_2)
      {
         super(param1,false);
      }
      
      override protected function getRowView() : IWindowController_1
      {
         return IWindowController_1(_navigator.getXmlWindow("ros_banned_user"));
      }
      
      override protected function onBgMouseClick(param1:WindowEvent) : void
      {
         _selectedRow = param1.target.parent.id;
         refreshColorsAfterClick(param1.target.findParentByName("moderation_banned_users") as IItemListWindow);
      }
      
      override protected function getBgColor(param1:int, param2:Boolean) : uint
      {
         if(param1 == _selectedRow)
         {
            return 4288329945;
         }
         return super.getBgColor(param1,param2);
      }
      
      private function refreshColorsAfterClick(param1:IItemListWindow) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowController_1 = null;
         _loc3_ = 0;
         while(_loc3_ < _userCount)
         {
            _loc2_ = IWindowController_1(param1.getListItemAt(_loc3_));
            _loc2_.color = this.getBgColor(_loc3_,false);
            _loc3_++;
         }
      }
      
      public function get selectedRow() : int
      {
         return _selectedRow;
      }
   }
}

