package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class FlatCategory
   {
      private var _nodeId:int;
      
      private var _nodeName:String;
      
      private var _visible:Boolean;
      
      private var _automatic:Boolean;
      
      private var _automaticCategoryKey:String;
      
      private var _globalCategoryKey:String;
      
      private var _staffOnly:Boolean;
      
      public function FlatCategory(param1:IMessageDataWrapper)
      {
         super();
         _nodeId = param1.readInteger();
         _nodeName = param1.readString();
         _visible = param1.readBoolean();
         _automatic = param1.readBoolean();
         _automaticCategoryKey = param1.readString();
         _globalCategoryKey = param1.readString();
         _staffOnly = param1.readBoolean();
      }
      
      public function get nodeId() : int
      {
         return _nodeId;
      }
      
      public function get nodeName() : String
      {
         return _nodeName;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function get automatic() : Boolean
      {
         return _automatic;
      }
      
      public function get staffOnly() : Boolean
      {
         return _staffOnly;
      }
      
      public function get automaticCategoryKey() : String
      {
         return _automaticCategoryKey;
      }
      
      public function get globalCategoryKey() : String
      {
         return _globalCategoryKey;
      }
      
      public function get visibleName() : String
      {
         return _globalCategoryKey == "" ? _nodeName : "${navigator.flatcategory.global." + _globalCategoryKey + "}";
      }
   }
}

