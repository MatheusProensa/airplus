package com.sulake.habbo.window.utils.tableview
{
   public class TableColumn
   {
      private var _id:String;
      
      private var _columnName:String;
      
      private var _widthFactor:Number;
      
      private var _alignment:String;
      
      public function TableColumn(param1:String, param2:String, param3:Number, param4:String = "center")
      {
         super();
         _id = param1;
         _columnName = param2;
         _widthFactor = param3;
         if(param4 == "left")
         {
            param4 = "none";
         }
         _alignment = param4;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get columnName() : String
      {
         return _columnName;
      }
      
      public function get widthFactor() : Number
      {
         return _widthFactor;
      }
      
      public function get alignment() : String
      {
         return _alignment;
      }
   }
}

