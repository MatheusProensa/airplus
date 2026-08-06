package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class OutgoingIngredient
   {
      private var _count:int;
      
      private var _furnitureClassName:String;
      
      public function OutgoingIngredient(param1:IMessageDataWrapper)
      {
         super();
         _count = param1.readInteger();
         _furnitureClassName = param1.readString();
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get furnitureClassName() : String
      {
         return _furnitureClassName;
      }
   }
}

