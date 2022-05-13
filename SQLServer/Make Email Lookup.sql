

SELECT   [IS_BaseData].[Base].[vwWH_UFDIR_EMAIL].[UF_UFID],
		 [IS_BaseData].[Base].[vwWH_UFDIR_EMAIL].[UF_EMAIL],
		 [IS_BaseData].[Base].[vwWH_UFDIR_NAME].[UF_NAME_TXT],
		 [IS_BaseData].[Base].[vwWH_UFDIR_EMAIL].[UF_PRIMARY_FLG]
		FROM [IS_BaseData].[Base].[vwWH_UFDIR_EMAIL] LEFT JOIN  [IS_BaseData].[Base].[vwWH_UFDIR_NAME]
		ON ([IS_BaseData].[Base].[vwWH_UFDIR_EMAIL].[UF_UFID] =  [IS_BaseData].[Base].[vwWH_UFDIR_NAME].[UF_UFID])
		WHERE  [IS_BaseData].[Base].[vwWH_UFDIR_EMAIL]. [UF_ACTIVE_FLG]='Y'
		;

	  