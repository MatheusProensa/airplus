package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveFriendMessageComposer;
   import com.sulake.habbo.friendlist.domain.Friend;
   import flash.utils.Dictionary;
   
   public class FriendRemoveView extends AlertView
   {
      private var _selected:Array;
      
      public function FriendRemoveView(param1:HabboFriendList)
      {
         super(param1,"friend_remove_confirm");
         _selected = param1.categories.getSelectedFriends();
      }
      
      override public function dispose() : void
      {
         _selected = null;
         super.dispose();
      }
      
      override internal function setupContent(param1:IWindowController_1) : void
      {
         param1.findChildByName("cancel").procedure = onClose;
         param1.findChildByName("ok").procedure = onRemove;
         var _loc4_:Array = [];
         for each(var _loc2_ in _selected)
         {
            _loc4_.push(_loc2_.name);
         }
         var _loc5_:String = Util.arrayToString(_loc4_);
         var _loc3_:Dictionary = new Dictionary();
         friendList.registerParameter("friendlist.removefriendconfirm.userlist","user_names",_loc5_);
      }
      
      private function onRemove(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Remove Ok clicked");
         var _loc3_:RemoveFriendMessageComposer = new RemoveFriendMessageComposer();
         for each(var _loc4_ in _selected)
         {
            _loc3_.addRemovedFriend(_loc4_.id);
         }
         friendList.send(_loc3_);
         dispose();
      }
   }
}

