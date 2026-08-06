package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RoomEventData implements IComponentInterfaceQueue
   {
      private var _adId:int;
      
      private var _ownerAvatarId:int;
      
      private var _ownerAvatarName:String;
      
      private var _flatId:int;
      
      private var _categoryId:int;
      
      private var _eventType:int;
      
      private var _eventName:String;
      
      private var _eventDescription:String;
      
      private var _creationTime:String;
      
      private var _expirationDate:Date;
      
      private var _disposed:Boolean;
      
      public function RoomEventData(param1:IMessageDataWrapper)
      {
         super();
         _adId = param1.readInteger();
         _ownerAvatarId = param1.readInteger();
         _ownerAvatarName = param1.readString();
         _flatId = param1.readInteger();
         _eventType = param1.readInteger();
         _eventName = param1.readString();
         _eventDescription = param1.readString();
         var _loc8_:int = param1.readInteger();
         var _loc5_:int = param1.readInteger();
         var _loc9_:Date = new Date();
         var _loc3_:Number = Number(_loc9_.getTime());
         var _loc2_:Number = _loc8_ * 60 * 1000;
         _loc3_ -= _loc2_;
         var _loc6_:Date = new Date(_loc3_);
         _creationTime = _loc6_.date + "-" + _loc6_.month + "-" + _loc6_.fullYear + " " + _loc6_.hours + ":" + _loc6_.minutes;
         var _loc7_:Number = Number(_loc9_.getTime());
         var _loc4_:Number = _loc5_ * 60 * 1000;
         _loc7_ += _loc4_;
         _expirationDate = new Date(_loc7_);
         _categoryId = param1.readInteger();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get adId() : int
      {
         return _adId;
      }
      
      public function get ownerAvatarId() : int
      {
         return _ownerAvatarId;
      }
      
      public function get ownerAvatarName() : String
      {
         return _ownerAvatarName;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get categoryId() : int
      {
         return _categoryId;
      }
      
      public function get eventType() : int
      {
         return _eventType;
      }
      
      public function get eventName() : String
      {
         return _eventName;
      }
      
      public function get eventDescription() : String
      {
         return _eventDescription;
      }
      
      public function get creationTime() : String
      {
         return _creationTime;
      }
      
      public function get expirationDate() : Date
      {
         return _expirationDate;
      }
   }
}

