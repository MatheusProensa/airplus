package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class EventCategory
   {
      private var _categoryId:int;
      
      private var _categoryName:String;
      
      private var _visible:Boolean;
      
      public function EventCategory(param1:IMessageDataWrapper)
      {
         super();
         _categoryId = param1.readInteger();
         _categoryName = param1.readString();
         _visible = param1.readBoolean();
      }
      
      public function get categoryId() : int
      {
         return _categoryId;
      }
      
      public function get categoryName() : String
      {
         return _categoryName;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
   }
}

