package com.sulake.habbo.avatar.structure
{
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.IPalette;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   
   public interface IFigureSetData
   {
      function getSetType(param1:String) : ISetType;
      
      function getPalette(param1:int) : IPalette;
      
      function getFigurePartSet(param1:int) : IFigurePartSet;
   }
}

