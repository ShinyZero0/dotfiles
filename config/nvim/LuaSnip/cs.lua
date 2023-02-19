return {
	s(
		{ trig = "rspc" },
		fmta(
			[[
        private <> <>
        public <> <>
        {
            get =>> <>;
            set =>> this.RaiseAndSetIfChanged(ref <>, value)
        }
        ]],
			{
				i(1),
				i(2),
				rep(1),
				i(3),
                rep(2),
                rep(2),
			}
		)
	),
}
