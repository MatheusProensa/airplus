package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RelationshipStatusInfo
   {
      private var _relationshipStatusType:int;
      
      private var _friendCount:int;
      
      private var _randomFriendId:int;
      
      private var _randomFriendName:String;
      
      private var _randomFriendFigure:String;
      
      public function RelationshipStatusInfo(param1:IMessageDataWrapper)
      {
         super();
         _relationshipStatusType = param1.readInteger();
         _friendCount = param1.readInteger();
         _randomFriendId = param1.readInteger();
         _randomFriendName = param1.readString();
         _randomFriendFigure = param1.readString();
      }
      
      public function get relationshipStatusType() : int
      {
         return _relationshipStatusType;
      }
      
      public function get friendCount() : int
      {
         return _friendCount;
      }
      
      public function get randomFriendId() : int
      {
         return _randomFriendId;
      }
      
      public function get randomFriendName() : String
      {
         return _randomFriendName;
      }
      
      public function get randomFriendFigure() : String
      {
         return _randomFriendFigure;
      }
   }
}

