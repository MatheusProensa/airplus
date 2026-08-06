package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class NodeData
   {
      private var _visible:Boolean;
      
      private var _icon:int;
      
      private var _pageId:int;
      
      private var _pageName:String;
      
      private var _localization:String;
      
      private var _children:Vector.<NodeData>;
      
      private var _offerIds:Vector.<int>;
      
      public function NodeData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _visible = param1.readBoolean();
         _icon = param1.readInteger();
         _pageId = param1.readInteger();
         _pageName = param1.readString();
         _localization = param1.readString();
         _offerIds = new Vector.<int>(0);
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _offerIds.push(param1.readInteger());
            _loc3_++;
         }
         _children = new Vector.<NodeData>(0);
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _children.push(new NodeData(param1));
            _loc3_++;
         }
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function get icon() : int
      {
         return _icon;
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get localization() : String
      {
         return _localization;
      }
      
      public function get children() : Vector.<NodeData>
      {
         return _children;
      }
      
      public function get offerIds() : Vector.<int>
      {
         return _offerIds;
      }
   }
}

