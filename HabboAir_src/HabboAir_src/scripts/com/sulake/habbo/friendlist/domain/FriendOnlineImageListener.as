package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   
   public class FriendOnlineImageListener implements UnknownIHabboAvatar1
   {
      private var UnknownVarFromFriendOnlineImageListener_Friend_1:Friend;
      
      private var _friendCategories:FriendCategories;
      
      private var _disposed:Boolean;
      
      public function FriendOnlineImageListener(param1:Friend, param2:FriendCategories)
      {
         super();
         UnknownVarFromFriendOnlineImageListener_Friend_1 = param1;
         _friendCategories = param2;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:IAvatarImage_2 = null;
         if(_friendCategories != null)
         {
            _loc2_ = _friendCategories.deps.avatarManager.createAvatarImage(UnknownVarFromFriendOnlineImageListener_Friend_1.figure,"h",null,null);
            if(_loc2_ && !_loc2_.isPlaceholder())
            {
               _friendCategories.notifyFriendOnline(UnknownVarFromFriendOnlineImageListener_Friend_1,_loc2_);
            }
            else if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromFriendOnlineImageListener_Friend_1 = null;
         _friendCategories = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

