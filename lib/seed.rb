class Seed
  class << self
    def start(title = "")
      realtime = Benchmark.measure do
        print_title(title)
        yield
      end

      time_completed = "%4f" % realtime.real
      print_footer(title, time_completed)
    end

    def step(subtitle = "")
      realtime = Benchmark.measure do
        print_subtitle(subtitle)
        yield
      end

      time_completed = "%4f" % realtime.real
      printf("   -> %s\n", time_completed + "s")
    end

    def print_title(title = "")
      printed_title = [DateTime.current.strftime("%Y%m%d%H%I%M%S"), title].join(" ") + ": seeding"
      printf("== %s %s\n", printed_title, "=" * (75 - printed_title.length))
    end

    def print_footer(title = "", time_completed)
      printed_footer = [DateTime.current.strftime("%Y%m%d%H%I%M%S"), title].join(" ") + ": seeded (#{time_completed}s)"
      printf("== %s %s\n", printed_footer, "=" * (75 - printed_footer.length))
    end

    def print_subtitle(subtitle = "")
      printf("-- %s\n", subtitle)
    end
  end
end
