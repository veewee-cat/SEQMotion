//	Made by Veewee cat
//	@veewee_cat

///	@class
///	@ignore
function SEQMotionSequenceStructManager( ) constructor
{
	#region Приватные методы

		///	@method
		///	@parameter {Asset.GMSequence} _sequence_index
		///	@return {Struct.Sequence}
		///	@ignore
		static __GetStructByAsset = function( _sequence_index )
		{
			return sequence_get( _sequence_index );
		};
	
	#endregion
};