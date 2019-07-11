<resource schema="ft">
	<meta name="title">s_region Test</meta>
	<meta name="description">S_region does not work correctly in Aladin. This table is for testing footprints in s_region</meta>
	<meta name="creationDate">2016-06-15T06:32:00</meta>
	<meta name="subject">Testing</meta>
	<meta name="creator.name">Mikhail Minin</meta>
	<meta name="contact.name">Mikhail Minin</meta>
	<meta name="contact.email">m.minin@jacobs-university.de</meta>
	<meta name="instrument">Simulated</meta>
	<meta name="facility">Jacobs University GIS Lab</meta>
	<meta name="source"></meta>
	<meta name="contentLevel"></meta>
	<meta name="type">Catalog</meta>
	<meta name="coverage">
		<meta name="Profile">Planetary</meta>
	</meta>

	<table id="epn_core" adql="True" onDisk="True">



    <meta name="referenceURL">http://lesia.obspm.fr</meta>
    <publish sets="ivo_managed"/>




		<mixin spatial_frame_type="body">//epntap2#table-2_0</mixin>
		<meta name="description">Aladin footprint issue</meta>
		<stc>
			Polygon ICRS [s_region]
		</stc>
 <column name="s_region"  type="spoly" ucd="phys.outline;obs.field" description="Provides footprint"/>
		<publish />
	</table>

	<data id="import">
		<sources>data/data.csv</sources>
		<csvGrammar>
			<rowfilter procDef="//products#define">
				<bind name="table">"\schema.epn_core"</bind>
			</rowfilter>
		</csvGrammar>
		<make table="epn_core">
			<rowmaker idmaps="*">
				<var key="granule_uid" source="guid" />
				<var key="granule_gid" source="ggid" />
				<var key="obs_id" source="obsid" />


				<var key="spatial_frame_type">"body"</var>
				<var key="processing_level">1</var>

				<var key="s_region">"Polygon UNKNOWNFrame 0 0 0 30 30 30 30 0 0 0"</var>

				<apply procDef="//epntap2#populate-2_0" name="fillepn">
					<bind name="granule_uid">@granule_uid</bind>
					<bind name="granule_gid">@granule_gid</bind>
					<bind name="obs_id">@obs_id</bind>
				<bind name="target_name">"Mars"</bind>
				<bind name="access_format">"Polygon"</bind>
				<bind name="spatial_frame_type">"body"</bind>
				<bind name="instrument_host_name">"none"</bind>
                                <bind name="processing_level">@processing_level</bind>
				</apply>
			</rowmaker>
		</make>
	</data>
<!--
<data id="collection" auto="false">
        <register services="__system__/tap#run"/>
        <make table="epn_core"/>
		<publish/>
</data>
-->
</resource>
