package com.sulake.habbo.communication.messages.parser.inventory.clothing
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FigureSetIdsMessageParser implements IMessageParser
   {
      private var _figureSetIds:Vector.<int>;
      
      private var _boundFurnitureNames:Vector.<String>;
      
      public function FigureSetIdsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _figureSetIds = new Vector.<int>(0);
         _boundFurnitureNames = new Vector.<String>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _figureSetIds.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _boundFurnitureNames.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return _figureSetIds;
      }
      
      public function get boundFurnitureNames() : Vector.<String>
      {
         return _boundFurnitureNames;
      }
   }
}

