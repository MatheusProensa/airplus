package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class FriendRequestData
   {
      private var _requestId:int;
      
      private var _requesterName:String;
      
      private var _requesterUserId:int;
      
      private var _figureString:String;
      
      public function FriendRequestData(param1:IMessageDataWrapper)
      {
         super();
         _requestId = param1.readInteger();
         _requesterName = param1.readString();
         _figureString = param1.readString();
         _requesterUserId = _requestId;
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
      
      public function get figureString() : String
      {
         return _figureString;
      }
   }
}

