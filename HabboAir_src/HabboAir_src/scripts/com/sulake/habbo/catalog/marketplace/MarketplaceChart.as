package com.sulake.habbo.catalog.marketplace
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MarketplaceChart
   {
      private var UnknownVarFromMarketplaceChart_Array_1:Array;
      
      private var UnknownVarFromMarketplaceChart_Array_2:Array;
      
      private var _chartWidth:int;
      
      private var UnknownVarFromMarketplaceChart_Int_1:int;
      
      private var _xMin:int = -30;
      
      private var UnknownVarFromMarketplaceChart_Int_2:int;
      
      public function MarketplaceChart(param1:Array, param2:Array)
      {
         super();
         UnknownVarFromMarketplaceChart_Array_1 = param1.slice();
         UnknownVarFromMarketplaceChart_Array_2 = param2.slice();
      }
      
      public function draw(param1:int, param2:int) : BitmapData
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:BitmapData = new BitmapData(param1,param2);
         if(!available)
         {
            return _loc8_;
         }
         UnknownVarFromMarketplaceChart_Int_2 = 0;
         for each(_loc5_ in UnknownVarFromMarketplaceChart_Array_2)
         {
            if(_loc5_ > UnknownVarFromMarketplaceChart_Int_2)
            {
               UnknownVarFromMarketplaceChart_Int_2 = _loc5_;
            }
         }
         var _loc6_:int = Math.pow(10,UnknownVarFromMarketplaceChart_Int_2.toString().length - 1);
         UnknownVarFromMarketplaceChart_Int_2 = Math.ceil(UnknownVarFromMarketplaceChart_Int_2 / _loc6_) * _loc6_;
         var _loc9_:TextField = new TextField();
         var _loc4_:TextFormat = new TextFormat();
         _loc9_.embedFonts = true;
         _loc4_.font = "Volter";
         _loc4_.size = 9;
         _loc9_.defaultTextFormat = _loc4_;
         _loc9_.text = UnknownVarFromMarketplaceChart_Int_2.toString();
         _loc8_.draw(_loc9_);
         _chartWidth = param1 - _loc9_.textWidth - 2;
         UnknownVarFromMarketplaceChart_Int_1 = param2 - _loc9_.textHeight;
         var _loc10_:int = _loc9_.textWidth;
         _loc9_.text = "0";
         _loc8_.draw(_loc9_,new Matrix(1,0,0,1,_loc10_ - _loc9_.textWidth + 1,param2 - _loc9_.textHeight - 1));
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(1,13421772);
         _loc3_.graphics.moveTo(0,0);
         _loc3_.graphics.lineTo(0,UnknownVarFromMarketplaceChart_Int_1);
         _loc7_ = 0;
         while(_loc7_ <= 5)
         {
            _loc5_ = (UnknownVarFromMarketplaceChart_Int_1 - 1) / 5 * _loc7_;
            _loc3_.graphics.moveTo(0,_loc5_);
            _loc3_.graphics.lineTo(_chartWidth - 1,_loc5_);
            _loc7_++;
         }
         _loc3_.graphics.lineStyle(2,255);
         _loc3_.graphics.moveTo(getX(0),getY(0));
         _loc7_ = 1;
         while(_loc7_ < UnknownVarFromMarketplaceChart_Array_1.length)
         {
            _loc3_.graphics.lineTo(getX(_loc7_),getY(_loc7_));
            _loc7_++;
         }
         _loc8_.draw(_loc3_,new Matrix(1,0,0,1,param1 - _chartWidth,(param2 - UnknownVarFromMarketplaceChart_Int_1) / 2));
         return _loc8_;
      }
      
      private function getX(param1:int) : Number
      {
         return _chartWidth + _chartWidth / -_xMin * UnknownVarFromMarketplaceChart_Array_1[param1];
      }
      
      private function getY(param1:int) : Number
      {
         return UnknownVarFromMarketplaceChart_Int_1 - UnknownVarFromMarketplaceChart_Int_1 / UnknownVarFromMarketplaceChart_Int_2 * UnknownVarFromMarketplaceChart_Array_2[param1];
      }
      
      public function get available() : Boolean
      {
         return UnknownVarFromMarketplaceChart_Array_1 && UnknownVarFromMarketplaceChart_Array_2 && UnknownVarFromMarketplaceChart_Array_1.length > 1;
      }
   }
}

