package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
   
   public class FriendRequest implements IComponentInterfaceQueue
   {
      public static const STATE_OPEN:int = 1;
      
      public static const STATE_ACCEPTED:int = 2;
      
      public static const STATE_DECLINED:int = 3;
      
      public static const STATE_FAILED:int = 4;
      
      private var _requestId:int;
      
      private var _requesterName:String;
      
      private var _requesterUserId:int;
      
      private var _state:int = 1;
      
      private var _disposed:Boolean;
      
      private var _view:IWindowController_1;
      
      public function FriendRequest(param1:FriendRequestData)
      {
         super();
         _requestId = param1.requestId;
         _requesterName = param1.requesterName;
         _requesterUserId = param1.requesterUserId;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(view != null)
         {
            view.destroy();
            view = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get requestId() : int
      {
         return _requestId;
      }
      
      public function get requesterName() : String
      {
         return _requesterName;
      }
      
      public function get requesterUserId() : int
      {
         return _requesterUserId;
      }
      
      public function get view() : IWindowController_1
      {
         return _view;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set view(param1:IWindowController_1) : void
      {
         _view = param1;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
   }
}

